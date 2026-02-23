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
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 16) {
            
            
            AsyncImage(url: movie.posterURL) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray
            }
            .frame(width: 110, height: 160)
            .cornerRadius(12)
            .shadow(radius: 8)
            
            VStack(alignment: .leading, spacing: 8) {
                
                
                Text(movie.title)
                    .font(.title2.bold())
                
                // RATING + RUNTIME + YEAR
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
                
                // GENRES
                if let genres = details?.genres {
                    WrapGenreView(genres: genres)
                }
                
                if let cert = certification, !cert.isEmpty {
                CertificateBadge(certificate: cert)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
    }
}

