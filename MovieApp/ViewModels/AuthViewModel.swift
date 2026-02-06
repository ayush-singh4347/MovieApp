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


@MainActor
final class AuthViewModel: ObservableObject {

    @Published var user: User?
    @Published var isLoading = false
    @Published var errorMessage: String?

    init() {
        self.user = Auth.auth().currentUser
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
            await storeToken(for: result.user)

            
            let db = Firestore.firestore()
            try await db.collection("users")
                .document(result.user.uid)
                .setData([
                    "email": email,
                    "watchlist": []
                ])

        } catch {
            self.errorMessage = error.localizedDescription
        }

        isLoading = false
    }


    
    func logout() {
        do {
            try Auth.auth().signOut()
            KeychainManager.delete(account: "firebase_id_token")
            self.user = nil
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
