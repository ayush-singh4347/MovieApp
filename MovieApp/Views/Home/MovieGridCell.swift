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
    @State private var animateBookmark = false
    @State private var isAdding = false

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
                animateBookmark = true
                
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                
                Task {
                    await watchlistVM.toggleWatchlist(movie: movie)
                }
                
                withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                    animateBookmark = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    animateBookmark = false
                }
                
            } label: {
                ZStack {
                    Circle()
                        .fill(.black.opacity(0.7))
                        .frame(width: 32, height: 32)
                    
                    Image(systemName:
                            watchlistVM.watchlistIds.contains(movie.id)
                          ? "bookmark.fill"
                          : "bookmark")
                    .foregroundColor(
                        watchlistVM.watchlistIds.contains(movie.id)
                        ? .purple
                        : .white
                    )
                        .scaleEffect(animateBookmark ? 1.3 : 1.0)
                        .rotationEffect(.degrees(animateBookmark ? -8 : 0))
                }
            }
            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: animateBookmark)
            .padding(8)
        }
        

    }
}
