//
//  dummy4.swift
//  MovieApp
//
//  Created by rentamac on 2/4/26.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {

    @Published var movies: [Movie] = []

    func loadDummyData() {
        movies = [
            Movie(
                id: 1,
                title: "Batman",
                posterPath: nil,
                rating: 0.0,
                releaseDate: nil
            ),
            Movie(
                id: 2,
                title: "Spiderman",
                posterPath: nil,
                rating: 0.0,
                releaseDate: nil
            )
        ]

    }
}
