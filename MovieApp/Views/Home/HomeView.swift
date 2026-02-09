import SwiftUI

struct HomeView: View {

    @StateObject private var viewModel = HomeViewModel()

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 12),
        count: 4
    )

    var body: some View {
        VStack(spacing: 16) {

            Text("What do you want to watch?")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)

            LazyVGrid(columns: columns, spacing: 12) {
                categoryButton(.nowPlaying)
                categoryButton(.popular)
                categoryButton(.topRated)
                categoryButton(.upcoming)
            }
            .padding(.horizontal)

            Divider()

            ScrollView {
                LazyVGrid(
                    columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ],
                    spacing: 16
                ) {
                    ForEach(viewModel.movies) { movie in
                        MovieGridCell(movie: movie)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)

        // ✅ PROFILE BUTTON FINALLY WORKS
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    ProfileView()
                } label: {
                    Image(systemName: "person.crop.circle")
                        .font(.title2)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchMovies()
            }
        }
    }

    private func categoryButton(_ category: MovieCategory) -> some View {
        Button {
            viewModel.selectedCategory = category
            Task { await viewModel.fetchMovies() }
        } label: {
            Text(category.rawValue)
                .font(.caption)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, minHeight: 36)
                .background(
                    viewModel.selectedCategory == category
                        ? Color.blue
                        : Color.gray.opacity(0.2)
                )
                .foregroundColor(
                    viewModel.selectedCategory == category
                        ? .white
                        : .gray
                )
                .cornerRadius(10)
        }
    }
}

