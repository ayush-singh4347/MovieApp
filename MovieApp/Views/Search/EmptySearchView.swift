//
//  EmptySearchView.swift
//  MovieApp
//
//  Created by rentamac on 2/4/26.
//

import Foundation
import SwiftUI

//struct EmptySearchView: View {
//    var body: some View {
//        VStack(spacing: 16) {
//            Image("MovieNotFound")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 1200, height: 200)
//                .font(.system(size: 50))
//                .foregroundColor(.gray)
//
//            Text("No movies found")
//                .font(.headline)
//
//            Text("Try a different title or spelling")
//                .font(.subheadline)
//                .foregroundColor(.gray)
//        }
//        .padding(.top, 80)
//    }
//}
//#Preview {
//    EmptySearchView()
//}
import SwiftUI

struct EmptySearchView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image("MovieNotFound")
                .font(.largeTitle)

            Text("We Are Sorry, We Cannot Find the Movie :(")
                .font(.headline)
                .multilineTextAlignment(.center)

            Text("Find your movie by title,categories, years, etc.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 40)
    }
}
