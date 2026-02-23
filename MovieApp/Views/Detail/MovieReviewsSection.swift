//
//  MovieReviewsSection.swift
//  MovieApp
//
//  Created by rentamac on 2/22/26.
//

import SwiftUI

struct MovieReviewsSection: View {
    
    @ObservedObject var vm: MovieDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            ForEach(vm.reviews) { review in
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(review.author)
                        .font(.headline)
                    
                    if let rating = review.rating {
                        Text("⭐️ \(rating,specifier: "%.1f")")
                    }
                    
                    Text(review.content)
                        .font(.subheadline)
                        .lineLimit(4)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
            }
        }
        .padding(.horizontal)
    }
}
