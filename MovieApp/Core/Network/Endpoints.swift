
import Foundation

struct Endpoints {

    static let baseURL = "https://api.themoviedb.org/3"

    static func trendingMovies(apiKey: String) -> String {
        return "\(baseURL)/trending/movie/day?api_key=\(apiKey)"
    }

    static func searchMovie(query: String, apiKey: String) -> String {
        return "\(baseURL)/search/movie?query=\(query)&api_key=\(apiKey)"
    }

    static func movieDetails(id: Int, apiKey: String) -> String {
        return "\(baseURL)/movie/\(id)?api_key=\(apiKey)"
    }
}
