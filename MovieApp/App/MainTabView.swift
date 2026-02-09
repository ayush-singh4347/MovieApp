import SwiftUI

struct MainTabView: View {

    var body: some View {

        TabView {

            NavigationView {
                HomeView()
            }
            .navigationViewStyle(.stack)
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
    }
}

