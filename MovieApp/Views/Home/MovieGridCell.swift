//
//  MovieGridCell.swift
//  MovieApp
//
//  Created by rentamac on 08/02/2026.
//



import SwiftUI

struct MovieGridCell: View {

    let movie: Movie
    @EnvironmentObject var watchlistVM: WatchlistViewModel
    @State private var isAdding = false
    @State private var addedToWatchlist = false
    var body: some View {
        ZStack(alignment: .topTrailing){
            
            VStack(alignment: .leading) {
                
                AsyncImage(url: movie.posterURL) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 220)
                .cornerRadius(12)
                .clipped()
                
                Text(movie.title)
                    .font(.caption)
                    .lineLimit(2)
            }
            Button{
                guard !addedToWatchlist else { return }
                isAdding = true
                Task{
                    await watchlistVM.addToWatchlist(movie: movie)
                    addedToWatchlist = true
                    isAdding = false
                }
            }label: {
                ZStack{
                    Circle()
                        .fill(.black.opacity(0.7))
                        .frame(width: 32, height: 32)
                    if isAdding{
                        ProgressView()
                            .tint(.white)
                            .scaleEffect(0.6)
                        
                    } else{
                        Image(systemName: addedToWatchlist ? "bookmark.fill" :"bookmark").foregroundColor(.white)
                    }
                }
            }.padding(8)
        }
    }
}
