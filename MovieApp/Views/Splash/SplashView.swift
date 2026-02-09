//
//  Splash.swift
//  MovieApp
//
//  Created by rentamac on 2/4/26.
//

import SwiftUI

struct SplashView: View {

    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0.5

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 16) {
                Image( "SplashIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.orange)
                    .scaleEffect(scale)
                    .opacity(opacity)

                Text("MovieApp")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .opacity(opacity)
            }
        }
        .onAppear {
            withAnimation(.easeIn(duration: 1.2)) {
                scale = 1.0
                opacity = 1.0
            }
        }
    }
}
