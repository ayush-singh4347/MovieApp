
import SwiftUI

//struct SearchView: View {
//    var body: some View {
//        Text("Search Screen")
//    }
//}
import SwiftUI

struct SearchView: View {

    @StateObject private var viewModel = SearchViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                VStack(spacing: 16) {
                    
                    TextField("Search movie", text: $viewModel.searchText)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    }
                    
                    
                    else if viewModel.searchText.isEmpty {
                        EmptyStateView(
                            systemImage: "film",
                            title: "Search for Movies",
                            message: "Find movies by title."
                        )
                        .padding(.top, 80)
                        .animation(.easeInOut, value: viewModel.searchText)
                    }
                    
                    
                    else if viewModel.searchText.count < 2 {
                        EmptyStateView(
                            systemImage: "keyboard",
                            title: "Keep Typing",
                            message: "Type at least 2 characters to search."
                        )
                        .padding(.top, 80)
                    }
                    
                    
                    else if viewModel.movies.isEmpty {
                        EmptyStateView(
                            systemImage: "magnifyingglass",
                            title: "No Movies Found",
                            message: "Try a different title or check the spelling."
                        )
                        .padding(.top, 80)
                    }
                    
                    else {
                        List(viewModel.movies) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                SearchMovieCardView(movie: movie)
                            }
                        }
                        .listStyle(.plain)
                    }
                    
                    Spacer()
                }
                .navigationTitle("Search")
            }
        }
    }
}
