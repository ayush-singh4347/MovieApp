//
//  MovieSimilarSection.swift
//  MovieApp
//
//  Created by rentamac on 2/22/26.
//
import SwiftUI

struct MovieSimilarSection: View {
    
    @ObservedObject var vm: MovieDetailViewModel
    @EnvironmentObject var watchlistVM: WatchlistViewModel
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        if vm.similarMovies.isEmpty {
            
            EmptyStateView(
                systemImage: "sparkles.tv",
                title: "No Similar Movies",
                message: "We couldn't find related movies for this title."
            )
            .padding(.top, 40)
            
        } else {
            LazyVGrid(columns: columns, spacing: 16) {
                
                ForEach(vm.similarMovies) { movie in
                    NavigationLink {
                        MovieDetailView(movie: movie)
                    } label: {
                        MovieGridCell(movie: movie)
                            .environmentObject(watchlistVM)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
    }
}
