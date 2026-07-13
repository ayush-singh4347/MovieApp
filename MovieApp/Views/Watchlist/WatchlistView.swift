import SwiftUI

struct WatchlistView: View {

    @StateObject private var viewModel = WatchlistViewModel()

    var body: some View {

        Group {

            
            if viewModel.isLoading {

                ProgressView("Loading...")
                    .scaleEffect(1.2)

            
            } else if let error = viewModel.errorMessage {

                Text(error)
                    .foregroundColor(.red)
                    .padding()

            
            } else if viewModel.movies.isEmpty {
                EmptyStateView(
                systemImage: "film.stack",
                title: "Your Watchlist is Empty",
                message: "Save movies to your watchlist and find them here anytime."
                )
                .padding(.top, 60)
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
