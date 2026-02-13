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
                        "theme": "system",
                        "notifications": true
                    ]
                ])
            }
            self.user = user
            authState = .authenticated
            await storeToken(for: user)
        } catch {
            self.infoMessage = error.localizedDescription
        }

        isLoading = false
    }

    
    func signup(email: String, password: String) async {
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


}
