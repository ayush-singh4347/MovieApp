//
//  SearchBarView.swift
//  MovieApp
//
//  Created by rentamac on 2/4/26.
//

import Foundation
import SwiftUI

struct SearchBarView: View {

    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")

            TextField("Search movies on TMDB", text: $text)
                .focused($isFocused)
                .submitLabel(.search)
                .autocorrectionDisabled()

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
        }
        .padding()
        .background(Color.gray)

        .cornerRadius(12)
        .padding()
    }
}
#Preview {
    SearchBarView(text: .constant(""))
}

