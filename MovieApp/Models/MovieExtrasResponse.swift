//
//  MovieExtrasResponse.swift
//  MovieApp
//
//  Created by rentamac on 2/22/26.
//

import Foundation

struct SimilarResponse: Decodable{
    let results: [Movie]
}

struct ReviewResponse: Decodable {
    let results: [Review]
}

struct Review: Identifiable, Decodable {
    let id: String
    let author: String
    let content: String
    let authorDetails: AuthorDetails?

    enum CodingKeys: String, CodingKey {
        case id
        case author
        case content
        case authorDetails = "author_details"
    }

    var rating: Double? {
        authorDetails?.rating
    }
}

struct AuthorDetails: Decodable {
    let rating: Double?
}
