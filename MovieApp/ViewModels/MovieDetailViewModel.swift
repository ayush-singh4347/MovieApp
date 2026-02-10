
import Foundation
import Combine
@MainActor
final class MovieDetailViewModel: ObservableObject {

    @Published var movie: MovieDetailResponse?
    @Published var cast: [CastMember] = []
    @Published var isInWatchlist = false
    @Published var isLoading = false
    

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

    func toggleWatchlist(movie: Movie) async {
        if isInWatchlist {
            // optional: remove later
        } else {
            await watchlistVM.addToWatchlist(movie: movie)
            isInWatchlist = true
        }
    }
}

