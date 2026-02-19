//
//  AuthVIewModel.swift
//  MovieApp
//
//  Created by rentamac on 2/5/26.
//

import Foundation
import FirebaseAuth
import Combine
import SwiftUI
import FirebaseFirestore

enum AuthState {
    case loading
    case unauthenticated
    case verificationPending(User)
    case authenticated
}



@MainActor
final class AuthViewModel: ObservableObject {

    @Published var user: User?
    @Published var isLoading = false
    @Published var infoMessage: String?
    @Published var authState: AuthState = .loading
    @Published var selectedTheme: AppTheme = .dark
    @Published var userAvatar: String = "avatar_boy1"


    private var authListener: AuthStateDidChangeListenerHandle?
    init() {
        listenToAuthState()
    }
    private func listenToAuthState() {
        authListener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }

            Task {
                        if let user = user {
                            try await user.reload()

                            if user.isEmailVerified {
                                self.authState = .authenticated
                                self.user = user
                                await self.loadUserPreferences(uid: user.uid)
                            } else {
                                self.authState = .verificationPending(user)
                            }
                        } else {
                            self.authState = .unauthenticated
                        }
                    }
                }
            }


    
    func login(email: String, password: String) async {
        isLoading = true
        infoMessage = nil

        do {
            let result = try await Auth.auth()
                .signIn(withEmail: email, password: password)

            let user = result.user
            try await user.reload()
            
            if !user.isEmailVerified {
                authState = .verificationPending(user)
                isLoading = false
                return
            }
            
            let check = Firestore.firestore()
                .collection("users")
                .document(user.uid)
            let snapshot = try await check.getDocument()
            if !snapshot.exists{
                try await check.setData([
                    "uid": user.uid,
                    "email": email,
                    "displayName": email.components(separatedBy: "@").first ?? "",
                    "photoURL": "",
                    "bio": "",
                    "joinedAt": Timestamp(date: Date()),
                    "watchlist": [],
                    "preferences": [
                        "theme": "dark",
                        "notifications": true
                    ]
                ])
            }
            self.user = user
            authState = .authenticated
            let data = snapshot.data()

            if let photoURL = data?["photoURL"] as? String,!photoURL.isEmpty {
                self.userAvatar = photoURL
            } else {
                self.userAvatar = "avatar_boy1"
            }

            if let prefs = data?["preferences"] as? [String: Any],
               let themeRaw = prefs["theme"] as? String,
               let theme = AppTheme(rawValue: themeRaw) {
                self.selectedTheme = theme
            }

            await storeToken(for: user)
        } catch {
            self.infoMessage = error.localizedDescription
        }

        isLoading = false
    }

    
    func signup(email: String, password: String) async {
        if let validationError = validatePassword(password) {
                infoMessage = validationError
                return
            }
        isLoading = true
        infoMessage = nil

        do {
            let result = try await Auth.auth()
                .createUser(withEmail: email, password: password)

            let newUser = result.user
            
            try await newUser.sendEmailVerification()
            
            authState = .verificationPending(newUser)
            
            infoMessage = "Verification email sent. Please verify to login."

        } catch let error as NSError {
            if error.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                
                do {
                    let result = try await Auth.auth()
                        .signIn(withEmail: email, password: password)
                    
                    let existingUser = result.user
                    try await existingUser.reload()
                    
                    if existingUser.isEmailVerified {
                        authState = .authenticated
                    } else {
                        authState = .verificationPending(existingUser)
                    }
                } catch {
                    infoMessage = "Account already exists. Try logging in."
                    authState = .unauthenticated
                }
            } else {
                    infoMessage = error.localizedDescription
                    }
                }

        isLoading = false
    }


    
    func logout() {
        do {
            try Auth.auth().signOut()
            KeychainManager.delete(account: "firebase_id_token")
            user = nil
            authState = .unauthenticated
        } catch {
            infoMessage = error.localizedDescription
        }
    }

    
    private func storeToken(for user: User) async {
        do {
            let token = try await user.getIDToken()
            KeychainManager.save(token: token, account: "firebase_id_token")
        } catch {
            print("Token fetch failed:", error.localizedDescription)
        }
    }
    
    func resendVerificationEmail(user: User) async {
       
        do {
            try await user.sendEmailVerification()
            infoMessage = "Verification email resent. Please verify to login."
        } catch {
            self.infoMessage = error.localizedDescription
        }
    }
    
    func resetPassword(email: String) async {
        isLoading = true
        infoMessage = nil

        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            infoMessage = "Password reset email sent."
        } catch {
            infoMessage = error.localizedDescription
        }

        isLoading = false
    }

    
    private func validatePassword(_ password: String) -> String? {

        if password.count < 8 {
            return "Password must be at least 8 characters."
        }

        let uppercase = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")
        if !uppercase.evaluate(with: password) {
            return "Password must contain at least one uppercase letter."
        }

        let lowercase = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*")
        if !lowercase.evaluate(with: password) {
            return "Password must contain at least one lowercase letter."
        }

        let number = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*")
        if !number.evaluate(with: password) {
            return "Password must contain at least one number."
        }

        let special = NSPredicate(format: "SELF MATCHES %@", ".*[!@#$%^&*(),.?\":{}|<>]+.*")
        if !special.evaluate(with: password) {
            return "Password must contain at least one special character."
        }

        return nil
    }
    func updateTheme(_ theme: AppTheme) async {
        selectedTheme = theme   

        guard let uid = user?.uid else { return }

        do {
            try await Firestore.firestore()
                .collection("users")
                .document(uid)
                .updateData([
                    "preferences.theme": theme.rawValue
                ])
        } catch {
            print("Theme update failed:", error.localizedDescription)
        }
    }
    
    
    private func loadUserPreferences(uid: String) async {
        do {
            let snapshot = try await Firestore.firestore()
                .collection("users")
                .document(uid)
                .getDocument()

            if let data = snapshot.data() {

                // Avatar
                if let avatar = data["photoURL"] as? String,
                   !avatar.isEmpty {
                    self.userAvatar = avatar
                }

                // Theme
                if let prefs = data["preferences"] as? [String: Any],
                   let themeRaw = prefs["theme"] as? String,
                   let theme = AppTheme(rawValue: themeRaw) {
                    self.selectedTheme = theme
                }
            }

        } catch {
            print("Failed to load preferences:", error.localizedDescription)
        }
    }


}
