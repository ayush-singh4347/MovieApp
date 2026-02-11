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
    case authenticated
    case unauthenticated
}



@MainActor
final class AuthViewModel: ObservableObject {

    @Published var user: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var authState: AuthState = .loading

    private var authListener: AuthStateDidChangeListenerHandle?
    init() {
        listenToAuthState()
    }
    private func listenToAuthState() {
            authListener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
                guard let self = self else { return }

                self.user = user

                if user != nil {
                    self.authState = .authenticated
                } else {
                    self.authState = .unauthenticated
                }
            }
        }
    
    func login(email: String, password: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let result = try await Auth.auth()
                .signIn(withEmail: email, password: password)

            self.user = result.user
            await storeToken(for: result.user)
        } catch {
            self.errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    
    func signup(email: String, password: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let result = try await Auth.auth()
                .createUser(withEmail: email, password: password)

            self.user = result.user
            self.authState = .authenticated

            let db = Firestore.firestore()

            try await db.collection("users")
                .document(result.user.uid)
                .setData([
                    "uid": result.user.uid,
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

            await storeToken(for: result.user)

        } catch {
            self.errorMessage = error.localizedDescription
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
            errorMessage = error.localizedDescription
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

}
