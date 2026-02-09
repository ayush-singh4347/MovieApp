//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by rentamac on 2/9/26.
//

import Foundation
import SwiftUI
struct MovieDetailView: View {
    let movie: Movie
    var body: some View {
        Text(movie.title)
            .font(Font.largeTitle)
    }
}
