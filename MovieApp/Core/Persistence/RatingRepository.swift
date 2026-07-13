//
//  RatingRepository.swift
//  MovieApp
//
//  Created by rentamac on 2/17/26.
//

import FirebaseFirestore
import FirebaseAuth

final class RatingRepository {

    private let db = Firestore.firestore()

    func fetchRating(movieId: Int) async throws -> Double? {

        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "AuthError", code: 401)
        }

        let snapshot = try await db
            .collection("users")
            .document(uid)
            .getDocument()

        let ratings = snapshot.data()?["ratings"] as? [String: Double]
        return ratings?["\(movieId)"]
    }

    func saveRating(movieId: Int, rating: Double) async throws {

        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "AuthError", code: 401)
        }

        try await db
            .collection("users")
            .document(uid)
            .setData(
                [
                    "ratings": [
                        "\(movieId)": rating
                    ]
                ],
                merge: true
            )
    }
}
