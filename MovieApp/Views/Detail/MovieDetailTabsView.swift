//
//  MovieDetailTabsView.swift
//  MovieApp
//
//  Created by rentamac on 2/22/26.
//
import SwiftUI

enum DetailTab: String, CaseIterable {
    case details = "Details"
    case reviews = "Reviews"
    case similar = "Similar"
}

struct MovieDetailTabsView: View {
    
    @ObservedObject var vm: MovieDetailViewModel
    let movie: Movie
    
    @State private var selectedTab: DetailTab = .details
    @Namespace private var animation
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            
            HStack {
                ForEach(DetailTab.allCases, id: \.self) { tab in
                    VStack {
                        
                        Button {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                selectedTab = tab
                            }
                        } label: {
                            Text(tab.rawValue)
                                .font(.subheadline.bold())
                                .foregroundColor(
                                    selectedTab == tab ? .primary : .secondary
                                )
                        }
                        
                        ZStack {
                            if selectedTab == tab {
                                Capsule()
                                    .fill(Color.blue)
                                    .matchedGeometryEffect(
                                        id: "underline",
                                        in: animation
                                    )
                                    .frame(height: 3)
                            } else {
                                Color.clear.frame(height: 3)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical, 12)
            
            Divider()
            
            
            Group {
                switch selectedTab {
                case .details:
                    ScrollView {
                        MovieDetailsSection(vm: vm)
                    }
                    
                case .reviews:
                    ScrollView {
                        MovieReviewsSection(vm: vm)
                    }
                    
                case .similar:
                    ScrollView {
                        MovieSimilarSection(vm: vm)
                    }
                }
            }
        }
    }
}
