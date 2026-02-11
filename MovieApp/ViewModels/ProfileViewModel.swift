//
//  ProfileViewModel.swift
//  MovieApp
//
//  Created by rentamac on 2/11/26.
//

import SwiftUI
import Combine
import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class ProfileViewModel: ObservableObject {

    @Published var profile: UserProfile?
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchProfile() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        isLoading = true

        do {
            let snapshot = try await Firestore.firestore()
                .collection("users")
                .document(uid)
                .getDocument()

            profile = try snapshot.data(as: UserProfile.self)

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func updateProfile(displayName: String, bio: String) async {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        do {
            try await Firestore.firestore()
                .collection("users")
                .document(uid)
                .updateData([
                    "displayName": displayName,
                    "bio": bio
                ])

            profile?.displayName = displayName
            profile?.bio = bio

        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
