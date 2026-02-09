import Foundation

final class MovieRepository {

    private let apiKey = "43af8191dc6d22f16e133e7f73e296d4"

    func fetchMovies(category: MovieCategory) async throws -> [Movie] {

        let urlString: String

        switch category {
        case .nowPlaying:
            urlString = Endpoints.nowPlaying(apiKey: apiKey)

        case .popular:
            urlString = Endpoints.popular(apiKey: apiKey)

        case .topRated:
            urlString = Endpoints.topRated(apiKey: apiKey)

        case .upcoming:
            urlString = Endpoints.upcoming(apiKey: apiKey)
        }

        let response: MovieResponse =
            try await APIClient.shared.request(urlString: urlString)

        return response.results
    }
}
