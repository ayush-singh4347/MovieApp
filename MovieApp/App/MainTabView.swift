import SwiftUI
enum Tab {
    case home
    case search
    case watchlist
    case profile
}


struct MainTabView: View {
    @StateObject private var watchlistVM = WatchlistViewModel()
    @State private var selectedTab: Tab = .home
    init() {
    let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)

   
    appearance.backgroundColor = UIColor.systemBackground

        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.purple)
    appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
    .foregroundColor: UIColor.systemPurple
    ]

    
    appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
    appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
    .foregroundColor: UIColor.gray
    ]

    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
    }
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
            NavigationStack {
                           ProfileView(selectedTab: $selectedTab)
                       }
                       .tabItem {
                           Label("Profile", systemImage: "person.crop.circle.fill")
                       }
                       .tag(Tab.profile)
        }
        .environmentObject(watchlistVM)
        
    }
}

