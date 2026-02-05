//
//  SearchView.swift
//  MovieApp
//
//  Created by rentamac on 2/4/26.
//

//import Foundation
//import SwiftUI
//
//struct SearchView: View {
//
//    @StateObject private var viewModel = SearchViewModel()
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//
//                SearchBarView(text: $viewModel.searchText)
//
//                if viewModel.isLoading {
//                    Spacer()
//                    ProgressView("Searching TMDB...")
//                    Spacer()
//                }
//
//                else if viewModel.showEmptyState {
//                    EmptySearchView()
//                }
//
//                else {
//                    ScrollView {
//                        LazyVGrid(
//                            columns: [
//                                GridItem(.flexible()),
//                                GridItem(.flexible())
//                            ],
//                            spacing: 16
//                        ) {
//                            ForEach(viewModel.movies) { movie in
//                                NavigationLink {
//                                    MovieDetailView(movieId: movie.id)
//                                } label: {
//                                    SearchMovieCardView(movie: movie)
//                                }
//                            }
//                        }
//                        .padding()
//                    }
//                }
//            }
//            .navigationTitle("Search")
//        }
//    }
//}
//
