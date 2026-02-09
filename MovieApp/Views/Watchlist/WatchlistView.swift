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

                List {

                    ForEach(viewModel.movies, id: \.id) { movie in

                        HStack(spacing: 15) {

                            // Poster
                            AsyncImage(url: movie.posterURL) { phase in

                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()

                                } else if phase.error != nil {
                                    Color.red

                                } else {
                                    Color.gray.opacity(0.3)
                                }
                            }
                            .frame(width: 70, height: 100)
                            .cornerRadius(8)



                            // Info
                            VStack(alignment: .leading, spacing: 6) {

                                Text(movie.title)
                                    .font(.headline)

                                Text("⭐️ \(String(format: "%.1f", movie.rating))")
                                    .foregroundColor(.gray)

                                if let date = movie.releaseDate {

                                    Text(date)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(.vertical, 5)
                    }
                    .onDelete(perform: viewModel.delete)
                }
            }
        }
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
