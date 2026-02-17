import SwiftUI

struct HomeView: View {
    @EnvironmentObject var watchlistVM: WatchlistViewModel
    @StateObject private var viewModel = HomeViewModel()
    @Binding var selectedTab: Tab

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 12),
        count: 4
    )

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                
                Text("What do you want to watch?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
//                NavigationLink {
//                    SearchView()
//                } label: {
//                    HStack(spacing: 12) {
//                        Image(systemName: "magnifyingglass")
//                            .foregroundColor(.secondary)
//                        
//                        Text("Search movies, actors, genres...")
//                            .foregroundColor(.secondary)
//                        
//                        Spacer()
//                    }
//                    .padding()
//                    .background(
//                        RoundedRectangle(cornerRadius: 12)
//                            .fill(Color.primary.opacity(0.08))
//                    )
//                }
//                .buttonStyle(.plain)
//                .padding(.horizontal)
                
                Button {
                    selectedTab = .search
                    print("tapped")
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)

                        Text("Search movies, actors, genres...")
                            .foregroundColor(.secondary)

                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                .padding(.horizontal)

                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        CategoryCard(
                            title: "Languages",
                            icon: "globe",
                            isSelected: viewModel.selectedCategory == .all
                        ) {
                            viewModel.showLanguageFilter = true
                        }
                        
                        
                        CategoryCard(
                            title: "Now Playing",
                            icon: "play.circle.fill",
                            isSelected: viewModel.selectedCategory == .nowPlaying
                        ) {
                            Task{
                                await viewModel.selectCategory(.nowPlaying)
                            }
                        }
                        
                        CategoryCard(
                            title: "Popular",
                            icon: "flame.fill",
                            isSelected: viewModel.selectedCategory == .popular
                        ) {
                            Task{
                                await viewModel.selectCategory(.popular)
                            }
                        }
                        
                        CategoryCard(
                            title: "Top Rated",
                            icon: "star.fill",
                            isSelected: viewModel.selectedCategory == .topRated
                        ) {
                            Task{
                                await viewModel.selectCategory(.topRated)
                            }
                        }
                        
                        CategoryCard(
                            title: "Upcoming",
                            icon: "clock.fill",
                            isSelected: viewModel.selectedCategory == .upcoming
                        ) {
                            Task{
                                await viewModel.selectCategory(.upcoming)
                            }
                        }
                        
                    }
                    .padding(.horizontal)
                }
                
                
                Divider()
                
                
                LazyVGrid(
                    columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ],
                    spacing: 16
                ) {
                    ForEach(viewModel.movies) { movie in
                        NavigationLink {
                            MovieDetailView(movie: movie)
                        } label: {
                            MovieGridCell(movie: movie)
                                .environmentObject(watchlistVM)
                        }
                        .buttonStyle(.plain) 
                    }

                }
                .padding()
            }
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)

       
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    ProfileView(selectedTab: $selectedTab)
                } label: {
                    Image(systemName: "person.crop.circle")
                        .font(.title2)
                }
            }
            }
            .onAppear {
                Task {
                    await viewModel.fetchMovies()
                    await watchlistVM.fetchWatchlist()
                }
            }
            .sheet(isPresented: $viewModel.showLanguageFilter) {
                LanguageFilterView(viewModel: viewModel)
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

//#Preview {
//    HomeView(selectedTab=.home)
//}
//
#Preview {
    HomeView(selectedTab: .constant(.home))
}
