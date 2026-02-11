import SwiftUI
enum Tab {
    case home
    case search
    case watchlist
}


struct MainTabView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {

        TabView(selection: $selectedTab) {

            NavigationStack {
                HomeView(selectedTab: $selectedTab)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(Tab.home)

            NavigationView {
                SearchView()
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            .tag(Tab.search)

            NavigationView {
                WatchlistView()
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Label("Watchlist", systemImage: "bookmark.fill")
            }
            .tag(Tab.watchlist)
        }
    }
}

