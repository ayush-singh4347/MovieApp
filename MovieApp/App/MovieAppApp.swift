import SwiftUI
import Firebase

@main
struct MovieAppApp: App {

    @StateObject private var authVM = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            AppEntryView()
                .environmentObject(authVM)
        }
    }
}
