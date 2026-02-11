//
//   ProfileView.swift
//  MovieApp
//
//  Created by rentamac on 09/02/2026.
//
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ProfileView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject private var vm = ProfileViewModel()
    
    @State private var isEditing = false
    @State private var isLoading = true
    @Binding var selectedTab: Tab
    
    var body: some View {
        ScrollView {
            if let profile = vm.profile{
                VStack(spacing: 24) {
                    
                    ZStack {
                        LinearGradient(
                            colors: [.purple, .black],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(height: 260)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        
                        VStack(spacing: 12) {
                            Circle()
                                .fill(.ultraThinMaterial)
                                .frame(width: 100, height: 100)
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 40))
                                )
                            
                            Text(profile.displayName)
                                .font(.title2)
                                .foregroundColor(.white)
                                .bold()
                            
                            Text(profile.bio)
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal,16)
                        }
                    }
                }
                .padding(.top)
                
                
                HStack(spacing: 16) {
                    Button {
                        //WatchlistView()
                        selectedTab = .watchlist
                    } label: {
                        statCard(
                            title: "Watchlist",
                            value: "\(profile.watchlist.count)",
                            icon: "bookmark.fill"
                        )
                    }
                    .buttonStyle(.plain)
                    
                    statCard(
                        title: "Movies",
                        value: "∞",
                        icon: "film.fill"
                    )
                }
                
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Account")
                        .font(.headline)
                    
                    HStack {
                        Image(systemName: "envelope.fill")
                        Text(profile.email)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
                VStack(spacing: 12) {
                    
                    Button {
                        isEditing = true
                    } label: {
                        Label("Edit Profile", systemImage: "pencil")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button(role: .destructive) {
                        authVM.logout()
                    } label: {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                            .frame(maxWidth: .infinity)
                    }
                }
                
                Spacer(minLength: 40)
                
                    .padding()
            } else if vm.isLoading{
                ProgressView()
                    .padding(.top,80)
            }else{
                Text("Profilenot found")
                    .padding(.top, 80)
            }
        }
        .navigationTitle("Profile")
        .sheet(isPresented: $isEditing) {
            if let profile = vm.profile{
                EditProfileView(
                    displayName: profile.displayName,
                    bio: profile.bio
                ) { newName, newBio in
                    Task{
                        await vm.updateProfile(displayName: newName, bio: newBio)
                    }
                }
            }
        }
        .task {
            await vm.fetchProfile()
        }
    }
}

    

    func statCard(title: String, value: String, icon: String) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title2)

            Text(value)
                .font(.title3)
                .bold()

            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }


