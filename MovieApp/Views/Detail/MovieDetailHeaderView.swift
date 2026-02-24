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
    let onPlay: () -> Void

    
    private let headerHeight: CGFloat = 300
    var body: some View {
        GeometryReader { geo in
            let offset = geo.frame(in: .global).minY
            let dynamicHeight = offset > 0 ? headerHeight + offset : headerHeight

            ZStack {
                
                AsyncImage(url: movie.posterURL) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.black
                }
                .frame(
                    width: geo.size.width,
                    height: dynamicHeight
                )
                .clipped()
                .offset(y: offset > 0 ? -offset : 0)
                
                LinearGradient(
                    colors: [.clear, .black.opacity(0.8)],
                    startPoint: .center,
                    endPoint: .bottom
                )
                
               
                if trailerKey != nil {
                    Menu {
                        Button {
                            onPlay()
                        } label: {
                            Label("YouTube", systemImage: "play.rectangle.fill")
                        }
                        
                        Button {
                            NotificationCenter.default.post(
                                name: NSNotification.Name("ShowNativePlayer"),
                                object: nil
                            )
                        } label: {
                            Label("AVPlayer", systemImage: "bolt.horizontal.fill")
                        }
                    } label: {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 72))
                            .foregroundColor(.white)
                            .shadow(radius: 12)
                    }.position(
                        x: geo.size.width / 2,
                        y: dynamicHeight / 2
                        )
                }
            }
        }
        .frame(height: headerHeight)
    }
}
