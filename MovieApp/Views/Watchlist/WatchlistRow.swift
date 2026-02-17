//
//  WatchlistRow.swift
//  MovieApp
//
//  Created by rentamac on 2/12/26.
//
import SwiftUI

struct WatchlistRow: View {

    let movie: Movie

    var body: some View {

        HStack(spacing: 16) {

            // Poster
            AsyncImage(url: movie.posterURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 90, height: 130)
            .cornerRadius(12)
            .shadow(radius: 8)

            VStack(alignment: .leading, spacing: 8) {

                Text(movie.title)
                    .font(.system(size:18, weight: .semibold))
                    .lineLimit(2)

                HStack(spacing: 6) {

                    Image(systemName: "star.fill")
                        .foregroundColor(.orange)
                        .font(.system(size:14))

                    Text(String(format: "%.1f", movie.rating))
                        .font(.system(size:15))
                        .foregroundColor(.orange)
                        .fontWeight(.bold)
                }

                if let date = movie.releaseDate {
                    HStack(spacing: 6) {
                                Image(systemName: "calendar")
                                    .font(.system(size: 13))

                                Text(String(date.prefix(4)))
                                    .font(.system(size: 14))
                            }
                    .opacity(0.8)
                }
                
                if let duration = movie.runtime {
                    HStack(spacing: 6) {
                            Image(systemName: "clock")
                                .font(.system(size: 13))

                            Text("\(duration)")
                                .font(.system(size: 14))
                        }
                        .opacity(0.9)
                }
            }

            Spacer()
        }
        .padding()
        .background(
            LinearGradient(
                colors: [Color(.secondarySystemBackground), Color(.systemGray6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(18)
        
    }
}
