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
    //@EnvironmentObject var authVM: AuthViewModel

    var body: some View {

        ZStack {

            if showSplash {
                SplashView()
            } else {
                switch authVM.authState {
                case .loading:
                    SplashView()
                case .unauthenticated:
                    LoginView()
                case .verificationPending(let user):
                    VerificationPendingView(user: user)
                case .authenticated:
                    MainTabView()
                }
            }
        }
        .environmentObject(authVM)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}
