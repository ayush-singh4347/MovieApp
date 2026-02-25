//
//  YoutubePlayerView.swift
//  MovieApp
//
//  Created by rentamac on 2/23/26.
//

import SwiftUI
import WebKit

struct YouTubePlayerView: UIViewRepresentable {
    
    let videoId: String
    
    func makeUIView(context: Context) -> WKWebView {
        //
        //        let webView = WKWebView()
        //        webView.scrollView.isScrollEnabled = false
        //        webView.isOpaque = false
        //        webView.backgroundColor = .black
        //        return webView
        //    }
        //
        //    func updateUIView(_ uiView: WKWebView, context: Context) {
        //        guard let url = URL(
        //            string: "https://www.youtube.com/watch?v=\(videoId)&playsinline=1"
        //        ) else { return }
        //
        //        uiView.load(URLRequest(url: url))
        //    }
        
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        
        //fix for Error 150/153
        let webView = WKWebView(frame: .zero, configuration: configuration)
        
        // We set a custom User Agent so YouTube recognizes the request as a valid mobile browser
        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1"
        
        webView.scrollView.isScrollEnabled = false;
        webView.isOpaque = false
        webView.backgroundColor = .black
        
        return webView
    }
        func updateUIView(_ uiView: WKWebView, context: Context) {
            // Updated URL string to ensure it folllows the correct embed format
            let urlString = "https://www.youtube.com/embed/\(videoId)?playsinline=1&enablejsapi=1&origin=https://www.youtube.com"
            
            guard let url = URL(string: urlString) else { return }
            uiView.load(URLRequest(url: url))
        }
    
}
