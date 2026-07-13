//
//  EmptyStateView.swift
//  MovieApp
//
//  Created by rentamac on 2/23/26.
//

import SwiftUI

struct EmptyStateView: View {
    
    let systemImage: String
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.purple, .blue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 80, height: 80)
                
                Image(systemName: systemImage)
                    .font(.system(size: 32))
                    .foregroundColor(.white)
            }
            
            Text(title)
                .font(.headline)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
        }
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity)
    }
}
