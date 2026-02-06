//
//  Dummy1.swift
//  MovieApp
//
//  Created by rentamac on 2/4/26.
//

import Foundation
//struct Movie: Identifiable {
//    let id: Int
//    let title: String
//}
struct Movie: Identifiable, Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    
    init(
           id: Int,
           title: String,
           posterPath: String? = nil,
           releaseDate: String? = nil,
           voteAverage: Double? = nil
       ) {
           self.id = id
           self.title = title
           self.posterPath = posterPath
           self.releaseDate = releaseDate
           self.voteAverage = voteAverage
       }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}


struct SearchResponse: Decodable {
    let results: [Movie]
}
