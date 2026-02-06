//
//  RootVIew.swift
//  MovieApp
//
//  Created by rentamac on 2/5/26.
//
import SwiftUI

struct RootView: View {

    @StateObject private var authVM = AuthViewModel()

    var body: some View {
        Group {
            if authVM.user != nil {
                MainTabView()
                    .environmentObject(authVM)
            } else {
                LoginView()
                    .environmentObject(authVM)
            }
        }
    }
}

