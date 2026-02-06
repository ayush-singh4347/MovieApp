//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by rentamac on 2/3/26.
//

import SwiftUI
import Firebase

@main
struct MovieAppApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
