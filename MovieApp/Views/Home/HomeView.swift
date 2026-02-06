
import SwiftUI

struct HomeView: View {

    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.movies) { movie in
                Text(movie.title)
            }
            .navigationTitle("Trending Movies")
            .onAppear {
                viewModel.loadDummyData()
            }
        }
    }
}

#Preview {
    HomeView()
}

