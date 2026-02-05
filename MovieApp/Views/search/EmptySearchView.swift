//
//  EmptySearchView.swift
//  MovieApp
//
//  Created by rentamac on 2/4/26.
//

import Foundation
import SwiftUI

struct EmptySearchView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass.circle")
                .font(.system(size: 50))
                .foregroundColor(.gray)

            Text("No movies found")
                .font(.headline)

            Text("Try a different title or spelling")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.top, 80)
    }
}
#Preview {
    EmptySearchView()
}
