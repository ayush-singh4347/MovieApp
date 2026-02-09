//
//  RootVIew.swift
//  MovieApp
//
//  Created by rentamac on 2/5/26.
//
import SwiftUI
import Combine

struct RootView: View {

    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        Group{
            if authVM.user != nil {
                MainTabView()
            } else {
                LoginView()
            }
        }
            
    }
}


