import SwiftUI

struct MovieDetailView: View {
    
    let movie: Movie
    
    @StateObject private var vm = MovieDetailViewModel()
    @EnvironmentObject var watchlistVM: WatchlistViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            VStack(spacing: 0) {
                
                MovieDetailHeaderView(
                    movie: movie,
                    trailerKey: vm.trailerKey,
                    isBookmarked: watchlistVM.watchlistIds.contains(movie.id),
                    onPlay: { vm.openTrailerExternally() },
                    onBookmark: {
                        Task {
                            await watchlistVM.toggleWatchlist(movie: movie)
                        }
                    }
                )
                MovieDetailInfoView(
                    movie: movie,
                    details: vm.movie,
                    certification: vm.certification
                )
                
                MovieDetailTabsView(vm: vm, movie: movie)
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(movie.title)
            .task {
                await vm.load(movieId: movie.id)
                await vm.loadTrailer(movieId: movie.id)
                await vm.loadUserRating(movieId: movie.id)
                await vm.loadSimilar(movieId: movie.id)
                await vm.loadReviews(movieId: movie.id)
                await vm.loadCertification(movieId: movie.id)
            }
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
        }
    }
}
