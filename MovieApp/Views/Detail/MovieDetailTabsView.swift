//
//  MovieDetailTabsView.swift
//  MovieApp
//
//  Created by rentamac on 2/22/26.
//
import SwiftUI

struct MovieDetailTabsView: View {
    
    @ObservedObject var vm: MovieDetailViewModel
    let movie: Movie
    
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 16) {
            
            Picker("", selection: $selectedTab) {
                Text("Details").tag(0)
                Text("Reviews").tag(1)
                Text("Similar").tag(2)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            switch selectedTab {
            case 0:
                MovieDetailsSection(vm: vm)

            case 1:
                MovieReviewsSection(vm: vm)

            case 2:
                MovieSimilarSection(vm: vm)

            default:
                EmptyView()
            }
        }
        .padding(.top)
    }
}
