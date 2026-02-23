
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
    @Published var similarMovies: [Movie] = []
    @Published var reviews: [Review] = []
    @Published var certification: String?

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
    func openTrailerExternally() {
        guard let key = trailerKey,
              let url = URL(string: "https://www.youtube.com/watch?v=\(key)") else { return }
        UIApplication.shared.open(url)
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
    
    func loadSimilar(movieId: Int) async {
        do {
            let response: SimilarResponse =
                try await APIClient.shared.request(
                    urlString: Endpoints.movieSimilar(id: movieId)
                )

            similarMovies = response.results
        } catch {
            print("Failed loading similar movies:", error.localizedDescription)
        }
    }
    
    func loadReviews(movieId: Int) async {
        do {
            let response: ReviewResponse =
                try await APIClient.shared.request(
                    urlString: Endpoints.movieReviews(id: movieId)
                )

            reviews = response.results
        } catch {
            print("Failed loading reviews:", error.localizedDescription)
        }
    }
    
    func loadCertification(movieId: Int) async {
        do {
            let response: ReleaseDateResponse =
                try await APIClient.shared.request(
                    urlString: Endpoints.movieReleaseDates(id: movieId)
                )

        
            if let us = response.results.first(where: { $0.iso_3166_1 == "US" }),
               let cert = us.release_dates.first(where: { !$0.certification.isEmpty })?.certification {
                certification = cert
            }
            
        } catch {
            print("Certification load failed:", error.localizedDescription)
        }
    }

}

