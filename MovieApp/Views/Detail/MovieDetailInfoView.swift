//
//  MovieDetailInfoView.swift
//  MovieApp
//
//  Created by rentamac on 2/23/26.
//
import SwiftUI

struct MovieDetailInfoView: View {
    
    let movie: Movie
    let details: MovieDetailResponse?
    let certification: String?
    let isBookmarked: Bool
    let onBookmark: () -> Void
    
    @State private var isExpanded = false
    @State private var animateBookmark = false
    private var shouldShowMore: Bool {
        movie.title.count > 20
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            HStack(alignment: .top, spacing: 16) {
                
                
                AsyncImage(url: movie.posterURL) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 110, height: 160)
                .cornerRadius(12)
                .shadow(radius: 8)
                
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    HStack(alignment: .top) {
                        
                        VStack(alignment: .leading, spacing: 4) {
                            
                            Text(movie.title)
                                .font(.title2.bold())
                                .lineLimit(isExpanded ? nil : 2)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            if shouldShowMore {
                                Button {
                                    withAnimation(.easeInOut) {
                                        isExpanded.toggle()
                                    }
                                } label: {
                                    Text(isExpanded ? "Less" : "More")
                                        .font(.caption)
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            animateBookmark = true
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)){
                            onBookmark()
                        }
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()

                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                animateBookmark = false
                            }
                        } label: {
                            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                            .font(.title3)
                            .foregroundColor(isBookmarked ? .purple : .secondary)
                            .scaleEffect(animateBookmark ? 1.3 : 1.0)
                            .rotationEffect(.degrees(animateBookmark ? -8 : 0))
                            .padding(8)
                            .background(Color(.secondarySystemBackground))
                            .clipShape(Circle())
                            .shadow(color: isBookmarked ? .purple.opacity(0.4) : .clear, radius: 6)
                            }
                            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: animateBookmark)
                    }
                    
                    
                    
                    HStack(spacing: 8) {
                        
                        Label(
                            "\(movie.rating, specifier: "%.1f")",
                            systemImage: "star.fill"
                        )
                        .foregroundColor(.orange)
                        
                        if let runtime = details?.runtime {
                            Text("• \(runtime) min")
                        }
                        
                        if let year = details?.releaseDate.prefix(4) {
                            Text("• \(year)")
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    
                    
                    if let genres = details?.genres {
                        WrapGenreView(genres: genres)
                    }
                    
                    
                   
                    CertificateBadge(
                        certificate: certification?.isEmpty == false
                        ? certification!
                        : "NR"
                    )
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}
