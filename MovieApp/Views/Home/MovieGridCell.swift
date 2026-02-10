//
//  MovieGridCell.swift
//  MovieApp
//
//  Created by rentamac on 08/02/2026.
//



import SwiftUI

struct MovieGridCell: View {

    let movie: Movie
    @EnvironmentObject var watchlistVM: WatchlistViewModel

    @State private var isAdding = false
    @State private var addedToWatchlist = false
    //@State private var isPressed = false


    var body: some View {
        ZStack(alignment: .topTrailing) {

            VStack(alignment: .leading, spacing: 8) {

                ZStack(alignment: .bottomLeading) {

                    AsyncImage(url: movie.posterURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                    .frame(height: 220)
                    .clipped()

                    
                    LinearGradient(
                        colors: [.clear, .black.opacity(1)],
                        startPoint: .center,
                        endPoint: .bottom
                    )

                    
                    VStack(alignment: .leading, spacing: 4) {

                        Text(movie.title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .lineLimit(2)

                        HStack(spacing: 6) {

                           
                            Image(systemName: "star.fill")
                                .font(.caption2)
                                .foregroundColor(.yellow)

                            Text(String(format: "%.1f", movie.rating))
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.9))

                            Spacer()

                            
                            if let year = movie.releaseDate {
                                Text(year)
                                    .font(.caption2)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                        }
                    }
                    .padding(10)
                }
                .cornerRadius(14)
            }

           
            Button {
                guard !addedToWatchlist else { return }
                isAdding = true

                Task {
                    await watchlistVM.addToWatchlist(movie: movie)
                    addedToWatchlist = true
                    isAdding = false
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(.black.opacity(0.7))
                        .frame(width: 32, height: 32)

                    if isAdding {
                        ProgressView()
                            .tint(.white)
                            .scaleEffect(0.6)
                    } else {
                        Image(systemName: addedToWatchlist ? "bookmark.fill" : "bookmark")
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(8)
            
        }
        

    }
}
