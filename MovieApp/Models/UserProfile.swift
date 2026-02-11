//
//  UserProfile.swift
//  MovieApp
//
//  Created by rentamac on 2/11/26.
//


import Foundation
import FirebaseFirestore

struct UserProfile: Codable, Identifiable {

    @DocumentID var id: String?

    let uid: String
    let email: String
    var displayName: String
    var bio: String
    var photoURL: String
    var watchlist: [Int]
    var joinedAt: Timestamp
}

