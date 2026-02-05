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
            Movie(id: 1, title: "Inception"),
            Movie(id: 2, title: "Interstellar"),
            Movie(id: 3, title: "Oppenheimer")
        ]
    }
}
