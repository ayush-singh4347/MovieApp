import SwiftUI

struct MainTabView: View {
    @StateObject private var watchlistVM = WatchlistViewModel()

    var body: some View {

        TabView {

            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            NavigationView {
                SearchView()
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }

            NavigationView {
                WatchlistView()
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Label("Watchlist", systemImage: "bookmark.fill")
            }
        }
        .environmentObject(watchlistVM)
    }
}

