//
//  SearchMovieCardView.swift
//  MovieApp
//
//  Created by rentamac on 2/4/26.
//

//import Foundation
//import SwiftUI
//
//struct SearchMovieCardView: View {
//
//    let movie: Movie
//
//    var body: some View {
//        VStack(alignment: .leading) {
//
//            AsyncImage(url: movie.posterURL) { image in
//                image.resizable()
//            } placeholder: {
//                Color.gray.opacity(0.3)
//            }
//            .frame(height: 220)
//            .cornerRadius(12)
//
//            Text(movie.title)
//                .font(.caption)
//                .lineLimit(2)
//        }
//    }
//}
import SwiftUI

struct SearchMovieCardView: View {

    let movie: Movie

    var body: some View {
        HStack(spacing: 12) {

            // Poster placeholder
            if let posterPath = movie.posterPath,
               let url = TMDBImage.posterURL(path: posterPath) {

                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 60, height: 90)

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 90)
                            .clipped()
                            .cornerRadius(8)

                    case .failure:
                        Image(systemName: "film")
                            .frame(width: 60, height: 90)

                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "film")
                    .frame(width: 60, height: 90)
            }


            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .font(.headline)

                if let releaseDate = movie.releaseDate {
                    Text(releaseDate)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Text("⭐️ \(String(format: "%.1f", movie.rating))")
                    .font(.caption)

            }

            Spacer()
        }
        .padding(.vertical, 6)
    }
}
