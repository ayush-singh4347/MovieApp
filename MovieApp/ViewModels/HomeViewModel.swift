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
    @Published var selectedCategory: MovieCategory = .nowPlaying
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showLanguageFilter = false
    @Published var selectedLanguages: Set<String> = []

   
    

    private let apiKey = "43af8191dc6d22f16e133e7f73e296d4"

    func fetchMovies() async {
        isLoading = true
        errorMessage = nil

        let urlString: String

        switch selectedCategory {
        case .nowPlaying:
            urlString = Endpoints.nowPlaying(apiKey: apiKey)
        case .popular:
            urlString = Endpoints.popular(apiKey: apiKey)
        case .topRated:
            urlString = Endpoints.topRated(apiKey: apiKey)
        case .upcoming:
            urlString = Endpoints.upcoming(apiKey: apiKey)
        case .all:
            await fetchMoviesForLanguages()
            isLoading = false
            return
        }

        do {
            let response: MovieResponse = try await APIClient.shared.request(urlString: urlString)
            movies = response.results
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
    
    func selectCategory(_ category: MovieCategory) async {
            guard selectedCategory != category else { return }

            selectedCategory = category
            await fetchMovies()
        }
    func fetchMoviesForLanguages() async {

        var allMovies: [Movie] = []

        for lang in selectedLanguages {
            let url = Endpoints.discoverMovies(
                language: lang,
                apiKey: apiKey
            )

            do {
                let response: SearchResponse = try await APIClient.shared.request(urlString: url)
                allMovies.append(contentsOf: response.results)
            } catch {
                print(error)
            }
        }

        // remove duplicates
        self.movies = Array(Set(allMovies))
    }



}
