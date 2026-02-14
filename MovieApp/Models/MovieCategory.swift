//
//  MovieCategory.swift
//  MovieApp
//
//  Created by rentamac on 09/02/2026.
//

import Foundation

enum MovieCategory: String, CaseIterable {
    case nowPlaying = "Now Playing"
    case popular = "Popular"
    case topRated = "Top Rated"
    case upcoming = "Upcoming"
    case all = "All"
}
