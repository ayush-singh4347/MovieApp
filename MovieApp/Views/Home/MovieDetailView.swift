import SwiftUI

struct MovieDetailView: View {

    let movie: Movie
    @StateObject private var vm = MovieDetailViewModel()
    @EnvironmentObject var watchlistVM: WatchlistViewModel

    private let headerHeight: CGFloat = 260
    private let posterHeight: CGFloat = 180

    var body: some View {
        ScrollView(showsIndicators: false) {

            VStack(alignment: .leading, spacing: 24) {

                // MARK: - HEADER (Background Poster + Play + Bookmark)
                ZStack {

                    // Background Poster
                    AsyncImage(url: movie.posterURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.black
                    }
                    .frame(height: headerHeight)
                    .clipped()
                    .overlay(
                        Rectangle()
                            .fill(Color.black.opacity(0.55))
                    )
                    .safeAreaPadding(.top)

                    //  PLAY BUTTON (CENTER)
                    if vm.trailerKey != nil {
                        Button {
                            vm.openTrailerExternally()
                        } label: {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 64))
                                .foregroundColor(.white)
                                .shadow(radius: 10)
                        }
                    }

                    //  BOOKMARK BUTTON (TOP-RIGHT)
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                Task {
                                    await watchlistVM.toggleWatchlist(movie: movie)
                                }
                            } label: {
                                Image(systemName:
                                    watchlistVM.watchlistIds.contains(movie.id)
                                    ? "bookmark.fill"
                                    : "bookmark"
                                )
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.black.opacity(0.6))
                                .clipShape(Circle())
                            }
                            .padding()
                        }
                        Spacer()
                    }
                }
                .frame(height: headerHeight)

                // MARK: - OVERLAPPING POSTER + TITLE
                HStack(alignment: .bottom, spacing: 16) {

                    AsyncImage(url: movie.posterURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 120, height: posterHeight)
                    .cornerRadius(14)
                    .shadow(radius: 10)
                    .offset(y: -(posterHeight / 2))

                    VStack(alignment: .leading, spacing: 8) {
                        Spacer()

                        Text(movie.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .lineLimit(2)

                        Text("⭐️ \(String(format: "%.1f", movie.rating))")
                            .foregroundColor(.gray)

                        if let date = movie.releaseDate {
                            Text("Released • \(date.prefix(4))")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, -(posterHeight / 2))

                // MARK: - OVERVIEW
                if let overview = vm.movie?.overview {
                    VStack(alignment: .leading, spacing: 10) {

                        Text("Overview")
                            .font(.headline)

                        Text(overview)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(14)
                    .padding(.horizontal)
                }

                // MARK: - RATE MOVIE (FIXED LOCATION)
                Button {
                    vm.tempRating = vm.userRating ?? 3
                    vm.showRatingSheet = true
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)

                        if let rating = vm.userRating {
                            Text("Your Rating: \(String(format: "%.1f", rating))")
                        } else {
                            Text("Rate this movie")
                        }
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(14)
                }
                .padding(.horizontal)

                // MARK: - CAST
                if !vm.cast.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {

                        Text("Cast")
                            .font(.headline)
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(vm.cast) { actor in
                                    VStack(spacing: 6) {

                                        AsyncImage(url: actor.profileURL) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            Color.gray
                                        }
                                        .frame(width: 70, height: 70)
                                        .clipShape(Circle())
                                        .shadow(radius: 4)

                                        Text(actor.name)
                                            .font(.caption)
                                            .frame(width: 80)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }

                Spacer(minLength: 30)
            }
        }
        .navigationBarTitleDisplayMode(.inline)

        // MARK: - RATING SHEET
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

        // MARK: - LOAD DATA (SINGLE TASK )
        .task {
            await vm.load(movieId: movie.id)
            await vm.loadTrailer(movieId: movie.id)
            await vm.loadUserRating(movieId: movie.id)
        }
    }
}
