import SwiftUI
import Combine
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class WatchlistViewModel: ObservableObject {

    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let repository = WatchlistRepository()

    // MARK: - Fetch Watchlist

    func fetchWatchlist() async {

        isLoading = true
        errorMessage = nil

        do {

            // Get IDs from Firebase
            let ids = try await repository.fetchWatchlistIds()

            print("Fetched IDs:", ids)

            var fetchedMovies: [Movie] = []

            // Fetch movie details from TMDB
            for id in ids {

                let url = Endpoints.movieById(id)

                let movie: Movie =
                    try await APIClient.shared.request(urlString: url)

                fetchedMovies.append(movie)
            }

            self.movies = fetchedMovies

        } catch {

            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    // MARK: - Delete (Local Only)

    func delete(at offsets: IndexSet) {

        guard let uid = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()

        // Get movie IDs to delete
        let idsToRemove = offsets.map { movies[$0].id }

        // Update local UI
        movies.remove(atOffsets: offsets)

        // Update Firebase
        Task {
            do {
                try await db
                    .collection("users")
                    .document(uid)
                    .updateData([
                        "watchlist": FieldValue.arrayRemove(idsToRemove)
                    ])
            } catch {
                print("Delete failed:", error.localizedDescription)
            }
        }
    }
    // MARK: - Add to Watchlist

    func addToWatchlist(movie: Movie) async {

        guard let uid = Auth.auth().currentUser?.uid else {
            errorMessage = "User not logged in"
            return
        }

        let db = Firestore.firestore()

        do {
            try await db
                .collection("users")
                .document(uid)
                .updateData([
                    "watchlist": FieldValue.arrayUnion([movie.id])
                ])

            print("Added to watchlist:", movie.id)

        } catch {
            errorMessage = error.localizedDescription
            print("Add to watchlist failed:", error.localizedDescription)
        }
    }


}
