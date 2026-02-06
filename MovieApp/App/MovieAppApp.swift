//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by rentamac on 2/3/26.
//

import SwiftUI

@main
struct MovieAppApp: App {
    init() {
          KeychainManager.shared.save(
              key: "TMDB_API_KEY",
              value: "43af8191dc6d22f16e133e7f73e296d4"
          )
      }
    var body: some Scene {
       
        WindowGroup {
            MainTabView()
        }
    }
}
