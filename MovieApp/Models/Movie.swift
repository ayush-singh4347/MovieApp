import Foundation

struct Movie: Identifiable, Decodable {

    let id: Int
    let title: String
    let posterPath: String?
    let rating: Double
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case rating = "vote_average"
        case releaseDate = "release_date"
    }
    
}
extension Movie {

    var posterPathURL: URL? {

        guard let path = posterPath else { return nil }

        return URL(
            string: "https://image.tmdb.org/t/p/w500\(path)"
        )
    }
}

