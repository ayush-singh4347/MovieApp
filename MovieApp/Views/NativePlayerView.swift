//
//  NativeAVPlayerView.swift
//  MovieApp
//
//  Created by rentamac on 2/23/26.
//

import SwiftUI
import AVKit

struct NativePlayerView: View {
    
    private let player = AVPlayer(url: URL(string: "https://ia600700.us.archive.org/10/items/CarsTrailer/CarsTrailer.mp4")!)
    
    var body: some View {
        VideoPlayer(player: player)
            .navigationTitle("Native AVPlayer")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
               
                player.play()
            }
            .onDisappear {
                
                player.pause()
            }
    }
}
