import Foundation

struct Movie: Identifiable, Decodable {

    let id: Int
    let title: String
    let posterPath: String?
    let rating: Double
    let releaseDate: String?
    let runtime: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case rating = "vote_average"
        case releaseDate = "release_date"
        case runtime = "runtime"
        
    }
}

// Poster URL helper
extension Movie {

    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}
