//
//  MovieResponse.swift
//  MovieApp
//
//  Created by rentamac on 08/02/2026.
//


import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}
