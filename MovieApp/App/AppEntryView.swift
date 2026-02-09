import SwiftUI

struct AppEntryView: View {

    @StateObject private var authVM = AuthViewModel()
    @State private var showSplash = true

    var body: some View {

        Group {

            if showSplash {

                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }

            } else {

                // Auth-based routing
                if authVM.user == nil {
                    LoginView()
                } else {
                    MainTabView()
                }
            }
        }
        .environmentObject(authVM)
    }
}
