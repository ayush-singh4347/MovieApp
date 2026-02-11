//
//  ContentView.swift
//  MovieApp
//
//  Created by rentamac on 2/3/26.
//

import SwiftUI

struct ContentView: View {

   // @StateObject private var authVM = AuthViewModel()

    var body: some View {
//        if authVM.user != nil {
//           AppEntryView()
//               .environmentObject(authVM)
//        } else {
//            LoginView()
//               .environmentObject(authVM)
//        }
        AppEntryView()
    }
}


#Preview {
    ContentView()
}
