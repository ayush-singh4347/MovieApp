//
//  MovieRepository.swift
//  MovieApp
//
//  Created by rentamac on 08/02/2026.
//
import Foundation

final class MovieRepository {

    private let apiKey = "43af8191dc6d22f16e133e7f73e296d4"

    func fetchTrendingMovies() async throws -> [Movie] {
        let url = Endpoints.trendingMovies(apiKey: apiKey)
        let response: MovieResponse = try await APIClient.shared.request(urlString: url)
        return response.results
    }
}

