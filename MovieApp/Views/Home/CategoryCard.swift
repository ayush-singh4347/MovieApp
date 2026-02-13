//
//  CategoryCard.swift
//  MovieApp
//
//  Created by rentamac on 2/10/26.
//
import SwiftUI

struct CategoryCard: View {

    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {

                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)

                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .frame(height: 70)
            .frame( minWidth: 70,maxWidth: .infinity)
            
            .background(
                LinearGradient(
                    colors: isSelected
                        ? [.blue, .purple]
                        : [.gray.opacity(0.4), .gray.opacity(0.2)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(14)
            .scaleEffect(isSelected ? 1.08 : 1.0)
            .shadow(
                color: isSelected ? .blue.opacity(0.4) : .clear,
                radius: 10
            )
            .animation(.spring(response: 0.35, dampingFraction: 0.7), value: isSelected)
        }
        .buttonStyle(.plain)
    }
}

