import SwiftUI
import Combine
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class WatchlistViewModel: ObservableObject {

    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var watchlistIds: Set<Int> = []


    private let repository = WatchlistRepository()


    func fetchWatchlist() async {

        isLoading = true
        errorMessage = nil

        do {
            let ids = try await repository.fetchWatchlistIds()

            watchlistIds = Set(ids)

            var fetchedMovies: [Movie] = []

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


    func delete(at offsets: IndexSet) {

        guard let uid = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()
        let idsToRemove = offsets.map { movies[$0].id }

        
        movies.remove(atOffsets: offsets)

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

            watchlistIds.insert(movie.id)

        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func toggleWatchlist(movie: Movie) async {

        guard let uid = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()

        if watchlistIds.contains(movie.id) {
            try? await db.collection("users")
                .document(uid)
                .updateData([
                    "watchlist": FieldValue.arrayRemove([movie.id])
                ])

            watchlistIds.remove(movie.id)

        } else {
            try? await db.collection("users")
                .document(uid)
                .updateData([
                    "watchlist": FieldValue.arrayUnion([movie.id])
                ])

            watchlistIds.insert(movie.id)
        }
    }

}
