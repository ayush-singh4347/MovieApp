//
//  AppEntryView.swift
//  MovieApp
//
//  Created by rentamac on 2/8/26.
//


import SwiftUI

struct AppEntryView: View {

    @StateObject private var authVM = AuthViewModel()
    @State private var path = NavigationPath()
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
        .onChange(of: authVM.user) { _, newUser in
            if newUser == nil {
                path = NavigationPath()
            }
        }

        
    }
}


