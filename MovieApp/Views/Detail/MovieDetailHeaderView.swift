//
//  MovieDetailHeaderView.swift
//  MovieApp
//
//  Created by rentamac on 2/22/26.
//

import SwiftUI

struct MovieDetailHeaderView: View {
    
    let movie: Movie
    let trailerKey: String?
    let isBookmarked: Bool
    let onPlay: () -> Void
    let onBookmark: () -> Void
    
    private let headerHeight: CGFloat = 300
    
    var body: some View {
        GeometryReader { geo in
            let offset = geo.frame(in: .global).minY
            
            ZStack(alignment: .bottomLeading) {
                
                AsyncImage(url: movie.posterURL) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.black
                }
                .frame(
                    width: geo.size.width,
                    height: offset > 0 ? headerHeight + offset : headerHeight
                )
                .clipped()
                .offset(y: offset > 0 ? -offset : 0)
                
                LinearGradient(
                    colors: [.clear, .black.opacity(0.8)],
                    startPoint: .center,
                    endPoint: .bottom
                )
                
                
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button(action: onBookmark) {
                            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(.black.opacity(0.6))
                                .clipShape(Circle())
                        }
                        .padding()
                    }
                    
                    Spacer()
                    
                    if trailerKey != nil {
                        Button(action: onPlay) {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 70))
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .frame(height: headerHeight)
    }
}
