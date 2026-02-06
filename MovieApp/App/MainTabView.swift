import SwiftUI

struct MainTabView: View {

    var body: some View {

        TabView {

            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }


            NavigationStack {
                SearchView()
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }


            NavigationStack {
                WatchlistView()
            }
            .tabItem {
                Label("Watchlist", systemImage: "bookmark.fill")
            }
        }
    }
}
