import SwiftUI
import Combine

@MainActor
class WatchlistViewModel: ObservableObject {

    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    // 🔹 Temporary (Mock Firebase IDs)
    private let mockWatchlistIds = [550, 299536, 603]

    // MARK: - Fetch Watchlist

    func fetchWatchlistFromServer() async {

        isLoading = true
        errorMessage = nil

        var fetchedMovies: [Movie] = []

        for id in mockWatchlistIds {

            let url = Endpoints.movieById(id)

            do {
                let movie: Movie =
                    try await APIClient.shared.request(urlString: url)

                fetchedMovies.append(movie)

            } catch {
                print("Failed to fetch movie:", error)
                self.errorMessage = error.localizedDescription
            }
        }

        self.movies = fetchedMovies
        self.isLoading = false
    }

    // MARK: - Delete (Local Only for Now)

    func delete(at offsets: IndexSet) {
        movies.remove(atOffsets: offsets)
    }
}
