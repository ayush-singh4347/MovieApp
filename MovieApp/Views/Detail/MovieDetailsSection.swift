//
//  MovieDetailsSection.swift
//  MovieApp
//
//  Created by rentamac on 2/22/26.
//

import SwiftUI

struct MovieDetailsSection: View {
    
    @ObservedObject var vm: MovieDetailViewModel
   
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            if let overview = vm.movie?.overview {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Overview")
                        .font(.headline)
                    
                    Text(overview)
                        .foregroundColor(.secondary)
                }
            }
            
            if !vm.cast.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("Cast")
                        .font(.headline)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(vm.cast) { actor in
                                VStack {
                                    AsyncImage(url: actor.profileURL) { image in
                                        image.resizable().scaledToFill()
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
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
