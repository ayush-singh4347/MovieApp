import FirebaseFirestore
import FirebaseAuth

final class WatchlistRepository {

    private let db = Firestore.firestore()

    func fetchWatchlistIds() async throws -> [Int] {

        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "AuthError", code: 401)
        }

        let snapshot = try await db
            .collection("users")
            .document(uid)
            .getDocument()

        let data = snapshot.data()

        let ids = data?["watchlist"] as? [Int] ?? []

        return ids
    }
}
