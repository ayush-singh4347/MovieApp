import SwiftUI
import Firebase

@main
struct MovieAppApp: App {

    @StateObject private var authVM = AuthViewModel()

    init() {
        FirebaseApp.configure()
    

          KeychainManager.save(
            token : "43af8191dc6d22f16e133e7f73e296d4",
              account: "TMDB_API_KEY"
             
          )
      }
    var body: some Scene {
       
        WindowGroup {
            AppEntryView()
                .environmentObject(authVM)
        }
    }
}
