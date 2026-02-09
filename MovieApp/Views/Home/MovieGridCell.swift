//
//  MovieGridCell.swift
//  MovieApp
//
//  Created by rentamac on 08/02/2026.
//


import SwiftUI

struct MovieGridCell: View {

    let movie: Movie

    var body: some View {
        VStack(alignment: .leading) {

            AsyncImage(url: movie.posterURL) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(height: 220)
            .cornerRadius(12)

            Text(movie.title)
                .font(.caption)
                .lineLimit(2)
        }
    }
}
