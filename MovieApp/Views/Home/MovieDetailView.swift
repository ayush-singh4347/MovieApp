import SwiftUI

struct MovieDetailView: View {

    let movie: Movie
    @StateObject private var vm = MovieDetailViewModel()

    var body: some View {
        ScrollView {

            VStack(alignment: .leading, spacing: 16) {

                // MARK: Poster Header
                ZStack(alignment: .bottomLeading) {

                    AsyncImage(url: movie.posterURL) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(height: 300)
                    .clipped()

                    LinearGradient(
                        colors: [.clear, .black.opacity(0.9)],
                        startPoint: .top,
                        endPoint: .bottom
                    )

                    VStack(alignment: .leading, spacing: 6) {
                        Text(movie.title)
                            .font(.title)
                            .bold()

                        Text("⭐️ \(String(format: "%.1f", movie.rating))")
                            .foregroundColor(.gray)
                    }
                    .padding()
                }

                // MARK: Watchlist Button
                Button {
                    Task {
                        await vm.toggleWatchlist(movie: movie)
                    }
                } label: {
                    HStack {
                            Image(systemName: vm.isInWatchlist ? "bookmark.fill" : "bookmark")
                            //Text(vm.isInWatchlist ? "Remove from Watchlist" : "Add to Watchlist")
                        }
//                    Label(
//                        vm.isInWatchlist ? "In Watchlist" : "Add to Watchlist",
//                        systemImage: vm.isInWatchlist ? "checkmark" : "plus"
//                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal)

                // MARK: Overview
                if let overview = vm.movie?.overview {
                    Text("Overview")
                        .font(.headline)
                        .padding(.horizontal)

                    Text(overview)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }

                // MARK: Cast
                if !vm.cast.isEmpty {
                    Text("Cast")
                        .font(.headline)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(vm.cast) { actor in
                                VStack {
                                    AsyncImage(url: actor.profileURL) { img in
                                        img.resizable()
                                    } placeholder: {
                                        Color.gray
                                    }
                                    .frame(width: 70, height: 70)
                                    .clipShape(Circle())

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
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await vm.load(movieId: movie.id)
        }
    }
}
