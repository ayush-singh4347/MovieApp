//
//  MovieDetailResponse.swift
//  MovieApp
//
//  Created by rentamac on 2/10/26.
//
import Foundation

struct ReleaseDateResponse: Decodable {
    let results: [ReleaseCountry]
}

struct ReleaseCountry: Decodable {
    let iso_3166_1: String
    let release_dates: [ReleaseDate]
}

struct ReleaseDate: Decodable {
    let certification: String
}
struct Genre: Decodable, Identifiable {
    let id: Int
    let name: String
}
struct MovieDetailResponse: Decodable {
    let id: Int
    let title: String
    let overview: String
    let backdropPath: String?
    let voteAverage: Double
    let releaseDate: String
    let runtime: Int?
    let genres: [Genre]

    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime, genres
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}
