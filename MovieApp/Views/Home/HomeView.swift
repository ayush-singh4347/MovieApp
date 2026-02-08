
import SwiftUI


struct HomeView: View {

    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button(role: .destructive) {
                        authVM.logout()
                    } label: {
                        Text("Logout")
                            .frame(maxWidth: .infinity)
                    }
                }

                Section {
                    ForEach(viewModel.movies) { movie in
                        Text(movie.title)
                    }
                }
            }
            .navigationTitle("Trending Movies")
            .onAppear {
                viewModel.loadDummyData()
            }
        }
    }
}
