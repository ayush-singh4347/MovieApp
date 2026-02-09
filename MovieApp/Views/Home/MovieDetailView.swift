//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by rentamac on 08/02/2026.
//


import SwiftUI

struct MovieDetailView: View {

    let movie: Movie

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                AsyncImage(url: movie.posterURL) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(height: 400)

                Text(movie.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
            }
        }
        .navigationTitle("Details")   // ✅ Works with NavigationStack
    }
}
