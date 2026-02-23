
import Foundation
import Combine
import SwiftUI
@MainActor
final class MovieDetailViewModel: ObservableObject {

    @Published var movie: MovieDetailResponse?
    @Published var cast: [CastMember] = []
    @Published var isInWatchlist = false
    @Published var isLoading = false
    @Published var trailerKey: String?

    @Published var userRating: Double? = nil
    @Published var showRatingSheet = false
    @Published var tempRating: Double = 3.0

    @Published var showTrailerSafari = false

    var trailerURL: URL? {
        guard let key = trailerKey else { return nil }
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }

    private let ratingRepository = RatingRepository()


    private let watchlistVM = WatchlistViewModel()

    func load(movieId: Int) async {
        isLoading = true

        async let details: MovieDetailResponse =
            APIClient.shared.request(
                urlString: Endpoints.movieById(movieId)
            )

        async let credits: CastResponse =
            APIClient.shared.request(
                urlString: Endpoints.movieCredits(id: movieId)
            )

        do {
            movie = try await details
            cast = try await credits.cast
        } catch {
            print(error.localizedDescription)
        }

        isLoading = false
    }
    func loadTrailer(movieId: Int) async {
        do {
            let response: VideoResponse =
                try await APIClient.shared.request(
                    urlString: Endpoints.movieVideos(id: movieId)
                )

            // official YouTube trailer
            trailerKey = response.results.first {
                $0.site == "YouTube" &&
                $0.type == "Trailer" &&
                $0.official
            }?.key

        } catch {
            print("Trailer not available")
        }
    }


    func toggleWatchlist(movie: Movie) async {
        if isInWatchlist {
            
        } else {
            await watchlistVM.addToWatchlist(movie: movie)
            isInWatchlist = true
        }
    }
    func loadUserRating(movieId: Int) async {
        do {
            userRating = try await ratingRepository.fetchRating(movieId: movieId)
        } catch {
            print("Failed to load rating:", error.localizedDescription)
        }
    }
    func submitRating(movieId: Int) async {
        do {
            try await ratingRepository.saveRating(
                movieId: movieId,
                rating: tempRating
            )
            userRating = tempRating
        } catch {
            print("Failed to save rating:", error.localizedDescription)
        }
    }

}

