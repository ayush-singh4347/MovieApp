
import SwiftUI
struct MovieDetailView: View {

    let movie: Movie
    @StateObject private var vm = MovieDetailViewModel()
    

    private let headerHeight: CGFloat = 260
    private let posterHeight: CGFloat = 180

    var body: some View {
        ScrollView(showsIndicators: false) {

            VStack(alignment: .leading, spacing: 24) {

                // MARK: - BACKGROUND POSTER ONLY
                ZStack(alignment: .topTrailing) {

                    AsyncImage(url: movie.posterURL) { image in
                        image
                            .resizable()
                            //.scaledToFit()
                            .scaledToFill()//  FITS PROPERLY
                    } placeholder: {
                        Color.black
                    }
                    .frame(height: headerHeight)
                    .clipped()
                    .overlay(
                        Rectangle()
                            .fill(Color.black.opacity(0.55))
                    ).safeAreaPadding(.top)


                    // Bookmark Button
                    Button {
                        Task {
                            await vm.toggleWatchlist(movie: movie)
                        }
                    } label: {
                        Image(systemName: vm.isInWatchlist ? "bookmark.fill" : "bookmark")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                    .padding()
                }

                // MARK: - OVERLAPPING POSTER + TITLE ROW
                HStack(alignment: .bottom, spacing: 16) {

                    // Small Poster (half overlap)
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
                    .offset(y: -(posterHeight / 2)) // PERFECT HALF OVERLAP

                    // Movie Info (aligned to poster bottom)
                    VStack(alignment: .leading, spacing: 8) {

                        Spacer() //  pushes text to bottom

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
                }
                .padding(.horizontal)
                .padding(.top, -(posterHeight / 2)) // aligns block correctly

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
        .task {
            await vm.load(movieId: movie.id)
            //await vm.checkWatchlist(movieId: movie.id)
        }
    }
}
