//
//  WrapGenreView.swift
//  MovieApp
//
//  Created by rentamac on 2/23/26.
//

import SwiftUI

struct WrapGenreView: View {
    
    let genres: [Genre]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(genres, id: \.id) { genre in
                    Text(genre.name)
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                }
            }
        }
    }
}
