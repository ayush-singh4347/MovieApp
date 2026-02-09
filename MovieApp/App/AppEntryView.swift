//
//  AppEntryView.swift
//  MovieApp
//
//  Created by rentamac on 2/8/26.
//

import SwiftUI

struct AppEntryView: View {
    @StateObject private var authVM = AuthViewModel()
    @State private var showSplash = true

    var body: some View {
        NavigationStack{
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
                RootView()
            }
        }
        .environmentObject(authVM)
    }
}
