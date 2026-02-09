
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
                    .onChange(of: viewModel.searchText) { _, newValue in
                        Task {
                            await viewModel.searchMovies()
                        }
                    }

                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }

              
                if !viewModel.isLoading &&
                    viewModel.movies.isEmpty &&
                    !viewModel.searchText.isEmpty {

                    EmptySearchView()
                }

               
                List(viewModel.movies) { movie in
                    SearchMovieCardView(movie: movie)
                }
                .listStyle(.plain)

                Spacer()
            }
            .navigationTitle("Search")
        }
    }
}
