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
    static func trendingMovies(apiKey: String) -> String {
        return "\(baseURL)/trending/movie/day?api_key=\(apiKey)"
    }

    static func searchMovie(query: String, apiKey: String) -> String {
        return "\(baseURL)/search/movie?query=\(query)&api_key=\(apiKey)"
    }

    static func movieDetails(id: Int, apiKey: String) -> String {
        return "\(baseURL)/movie/\(id)?api_key=\(apiKey)"
    }
    
    static func movieById(_ id: Int) -> String {
        return "\(baseURL)/movie/\(id)?api_key=\(APIConstants.apiKey)"
    }
    static func movieCredits(id: Int) -> String {
        return "\(baseURL)/movie/\(id)/credits?api_key=\(APIConstants.apiKey)"
    }
    static func movieVideos(id: Int) -> String {
        return "\(baseURL)/movie/\(id)/videos?api_key=\(APIConstants.apiKey)"
    }
    static func discoverMovies(language: String, apiKey: String) -> String {
        "\(baseURL)/discover/movie?with_original_language=\(language)&api_key=\(apiKey)"
    }


}

