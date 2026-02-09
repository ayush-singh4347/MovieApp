//
//   ProfileView.swift
//  MovieApp
//
//  Created by rentamac on 09/02/2026.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 120, height: 120)
                .foregroundColor(.blue)

            Text("My Profile")
                .font(.title)
                .fontWeight(.bold)

            Text("User details go here")
                .foregroundColor(.gray)
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProfileView()
}
