//
//  StarRatingView.swift
//  MovieApp
//
//  Created by rentamac on 2/17/26.
//

import SwiftUI

struct StarRatingView: View {

    @Binding var rating: Double
    private let maxRating = 5

    var body: some View {
        HStack(spacing: 12) {
            ForEach(1...maxRating, id: \.self) { index in
                Image(systemName: rating >= Double(index) ? "star.fill" : "star")
                    .font(.system(size: 36))
                    .foregroundColor(.orange)
                    .scaleEffect(rating >= Double(index) ? 1.2 : 1.0)
                    .animation(
                        .spring(response: 0.3, dampingFraction: 0.6),
                        value: rating
                    )
                    .onTapGesture {
                        rating = Double(index)
                    }
            }
        }
    }
}
