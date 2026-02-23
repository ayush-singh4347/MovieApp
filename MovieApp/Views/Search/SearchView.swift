
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

          
                TextField("Search movie", text: $viewModel.searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                 
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }

              
                if !viewModel.isLoading &&
                    viewModel.movies.isEmpty &&
                    !viewModel.searchText.isEmpty {

                    EmptyStateView(
                        systemImage: "magnifyingglass",
                        title: "No Movies Found",
                        message: "Try searching with a different title, category, or year."
                    )
                    .padding(.top, 60)
                }

               
                List(viewModel.movies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        SearchMovieCardView(movie: movie)
                    }
                    
                }
                .listStyle(.plain)

                Spacer()
            }
            .navigationTitle("Search")
        }
    }
}
