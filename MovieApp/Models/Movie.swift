//
//  Dummy1.swift
//  MovieApp
//
//  Created by rentamac on 2/4/26.
//
import Foundation

struct Movie: Identifiable, Decodable {
    let id: Int
    let title: String
    let poster_path: String?

    var posterURL: URL? {
        guard let poster_path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(poster_path)")
    }
}

