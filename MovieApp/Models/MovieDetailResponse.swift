//
//  MovieDetailResponse.swift
//  MovieApp
//
//  Created by rentamac on 2/10/26.
//
import Foundation
struct MovieDetailResponse: Decodable {
    let id: Int
    let title: String
    let overview: String
    let backdropPath: String?
    let voteAverage: Double
    let releaseDate: String
    let runtime: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}
