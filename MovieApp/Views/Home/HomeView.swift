import SwiftUI

struct HomeView: View {

    @StateObject private var viewModel = HomeViewModel()

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {

            if viewModel.isLoading {
                ProgressView("Loading movies...")
            }

            else if let error = viewModel.errorMessage {
                VStack(spacing: 12) {
                    Text(error)
                        .foregroundColor(.red)

                    Button("Retry") {
                        Task {
                            await viewModel.loadTrendingMovies()
                        }
                    }
                }
            }

            else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.movies) { movie in
                            NavigationLink {
                                MovieDetailView(movie: movie)
                            } label: {
                                MovieGridCell(movie: movie)
                            }
                        }
                    }
                    .padding()
                }
                .refreshable {
                    await viewModel.loadTrendingMovies()
                }
            }
        }
        .navigationTitle("Trending Movies")
        .task {
            await viewModel.loadTrendingMovies()
        }
    }
}
