import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @StateObject private var vm = MovieDetailViewModel()
    @EnvironmentObject var watchlistVM: WatchlistViewModel
    
    
    @State private var activePlayer: PlayerChoice? = nil

    enum PlayerChoice: Identifiable {
        case youtube, native
        var id: Int { hashValue }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                MovieDetailHeaderView(
                    movie: movie,
                    trailerKey: vm.trailerKey,
                    onPlay: {
                        
                        activePlayer = .youtube
                    }
                )
                
                MovieDetailInfoView(movie: movie, details: vm.movie, certification: vm.certification,isBookmarked: watchlistVM.watchlistIds.contains(movie.id),
                                    onBookmark: {
                                    Task {
                                    await watchlistVM.toggleWatchlist(movie: movie)
                                    }
                }).padding(.bottom, 8)
               
                Button {
                    vm.tempRating = vm.userRating ?? 3.0
                    vm.showRatingSheet = true
                } label: {
                    HStack(spacing: 10) {
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                        
                        if let rating = vm.userRating {
                            Text("Your Rating: \(rating, specifier: "%.1f")")
                                .fontWeight(.semibold)
                        } else {
                            Text("Rate this movie")
                                .foregroundColor(Color(.secondaryLabel))
                                .fontWeight(.semibold)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.purple.opacity(0.2), .blue.opacity(0.4)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(14)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                MovieDetailTabsView(vm: vm, movie: movie)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(movie.title)
        .sheet(isPresented: $vm.showRatingSheet) {
            RatingSheetView(
                rating: $vm.tempRating,
                onSubmit: {
                    Task {
                        await vm.submitRating(movieId: movie.id)
                        vm.showRatingSheet = false
                    }
                }
            )
        }
        
        .sheet(item: $activePlayer) { choice in
            Group {
                switch choice {
                case .youtube:
                    if let key = vm.trailerKey {
                        YouTubePlayerView(videoId: key)
                    }
                case .native:
                    NativePlayerView()
                }
            }
            .ignoresSafeArea()
            .presentationDragIndicator(.visible)
        }
        
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("ShowNativePlayer"))) { _ in
            activePlayer = .native
        }
        .task {
            await vm.load(movieId: movie.id)
            await vm.loadTrailer(movieId: movie.id)
            await vm.loadUserRating(movieId: movie.id)
            await vm.loadSimilar(movieId: movie.id)
            await vm.loadReviews(movieId: movie.id)
            await vm.loadCertification(movieId: movie.id)
        }
    }
}
//struct MovieDetailView: View {
//    
//    let movie: Movie
//    
//    @StateObject private var vm = MovieDetailViewModel()
//    @EnvironmentObject var watchlistVM: WatchlistViewModel
//    
//    var body: some View {
//        ScrollView(showsIndicators: false) {
//            
//            VStack(spacing: 0) {
//                
//                MovieDetailHeaderView(
//                    movie: movie,
//                    trailerKey: vm.trailerKey,
//                    isBookmarked: watchlistVM.watchlistIds.contains(movie.id),
//                    onPlay: { vm.openTrailerExternally() },
//                    onBookmark: {
//                        Task {
//                            await watchlistVM.toggleWatchlist(movie: movie)
//                        }
//                    }
//                )
//                MovieDetailInfoView(
//                    movie: movie,
//                    details: vm.movie,
//                    certification: vm.certification
//                )
//                
//                MovieDetailTabsView(vm: vm, movie: movie)
//            }
//            
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationTitle(movie.title)
//            .task {
//                await vm.load(movieId: movie.id)
//                await vm.loadTrailer(movieId: movie.id)
//                await vm.loadUserRating(movieId: movie.id)
//                await vm.loadSimilar(movieId: movie.id)
//                await vm.loadReviews(movieId: movie.id)
//                await vm.loadCertification(movieId: movie.id)
//            }
//            .sheet(isPresented: $vm.showRatingSheet) {
//                RatingSheetView(
//                    rating: $vm.tempRating,
//                    onSubmit: {
//                        Task {
//                            await vm.submitRating(movieId: movie.id)
//                            vm.showRatingSheet = false
//                        }
//                    }
//                )
//            }
//        }
//    }
//}
