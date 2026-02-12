//
//  VideoResponse.swift
//  MovieApp
//
//  Created by rentamac on 2/11/26.
//


import Foundation

struct VideoResponse: Decodable {
    let results: [Video]
}

struct Video: Decodable {
    let key: String
    let site: String
    let type: String
    let official: Bool
}
