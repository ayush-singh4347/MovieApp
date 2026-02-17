import SwiftUI

struct WatchlistView: View {

    @StateObject private var viewModel = WatchlistViewModel()

    var body: some View {

        Group {

            // Loading
            if viewModel.isLoading {

                ProgressView("Loading...")
                    .scaleEffect(1.2)

            // Error
            } else if let error = viewModel.errorMessage {

                Text(error)
                    .foregroundColor(.red)
                    .padding()

            // Empty
            } else if viewModel.movies.isEmpty {

                VStack(spacing: 20) {

                    Image(systemName: "tray")
                        .font(.system(size: 60))

                    Text("No Movies Yet")
                        .font(.headline)

                    Text("Add movies to your watchlist")
                        .foregroundColor(.gray)
                }

            // List
            } else {
                ScrollView{
                LazyVStack {

                    ForEach(viewModel.movies, id: \.id) { movie in
                        NavigationLink {
                            MovieDetailView(movie: movie)
                        } label: {
                            WatchlistRow(movie: movie)
                                    }
                        .buttonStyle(.plain)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Watchlist")

        // Load on open
        .task {
            await viewModel.fetchWatchlist()
        }
    }
}

#Preview {
    NavigationStack {
        WatchlistView()
    }
}
