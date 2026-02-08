//
//  AppEntryView.swift
//  MovieApp
//
//  Created by rentamac on 2/8/26.
//

import SwiftUI

struct AppEntryView: View {

    @State private var showSplash = true

    var body: some View {
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
}
