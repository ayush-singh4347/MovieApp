//
//  MovieCategoryBar.swift
//  MovieApp
//
//  Created by rentamac on 09/02/2026.
//

import SwiftUI

struct MovieCategoryBar: View {

    @Binding var selectedCategory: MovieCategory
    let onSelect: () -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(MovieCategory.allCases, id: \.self) { category in
                    Button {
                        selectedCategory = category
                        onSelect()
                    } label: {
                        Text(category.rawValue)
                            .fontWeight(.semibold)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 14)
                            .background(
                                selectedCategory == category
                                ? Color.blue
                                : Color.clear
                            )
                            .foregroundColor(
                                selectedCategory == category
                                ? .white
                                : .gray
                            )
                            .cornerRadius(16)
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 44) // 👈 IMPORTANT
    }
}

