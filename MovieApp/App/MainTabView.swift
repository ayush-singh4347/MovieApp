
import SwiftUI

struct MainTabView: View {

    var body: some View {
        TabView {

            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            WatchlistView()
                .tabItem {
                    Label("Watchlist", systemImage: "bookmark.fill")
                }
        }
    }
}
