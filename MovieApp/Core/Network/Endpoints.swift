import Foundation

struct Endpoints {

    static let baseURL = "https://api.themoviedb.org/3"

    static func nowPlaying(apiKey: String) -> String {
        "\(baseURL)/movie/now_playing?api_key=\(apiKey)"
    }

    static func popular(apiKey: String) -> String {
        "\(baseURL)/movie/popular?api_key=\(apiKey)"
    }

    static func topRated(apiKey: String) -> String {
        "\(baseURL)/movie/top_rated?api_key=\(apiKey)"
    }

    static func upcoming(apiKey: String) -> String {
        "\(baseURL)/movie/upcoming?api_key=\(apiKey)"
    }
}

