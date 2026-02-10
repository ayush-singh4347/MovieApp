//
//  CastResponse.swift
//  MovieApp
//
//  Created by rentamac on 2/10/26.
//
import Foundation
struct CastResponse: Decodable {
    let cast: [CastMember]
}

struct CastMember: Identifiable, Decodable {
    let id: Int
    let name: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case profilePath = "profile_path"
    }

    var profileURL: URL? {
        guard let profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w185\(profilePath)")
    }
}
