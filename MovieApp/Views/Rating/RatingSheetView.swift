//
//  RatingSheetView.swift
//  MovieApp
//
//  Created by rentamac on 2/17/26.
//

import SwiftUI

struct RatingSheetView: View {

    @Binding var rating: Double
    let onSubmit: () -> Void

    var body: some View {
        VStack(spacing: 24) {

            Text("Rate this movie")
                .font(.headline)

            Text(String(format: "%.1f", rating))
                .font(.largeTitle)
                .fontWeight(.bold)

            StarRatingView(rating: $rating)

            Button("OK") {
                onSubmit()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)

            Spacer()
        }
        .padding()
        .presentationDetents([.height(280)])
    }
}
