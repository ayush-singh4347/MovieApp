//
//  dummy4.swift
//  MovieApp
//
//  Created by rentamac on 2/4/26.
//
import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let repository = MovieRepository()

    func loadTrendingMovies() async {
        isLoading = true
        errorMessage = nil

        do {
            let result = try await repository.fetchTrendingMovies()
            movies = result
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}


