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
    var themeCard: some View {
        VStack(spacing: 12) {

            HStack {
                Image(systemName: authVM.selectedTheme == .dark ? "moon.fill" : "sun.max.fill")
                    .foregroundColor(.white)

                Text(authVM.selectedTheme == .dark ? "Dark Mode" : "Light Mode")
                    .foregroundColor(.white)
                    .font(.headline)

                Spacer()
            }

            Toggle("", isOn: Binding(
                get: { authVM.selectedTheme == .dark },
                set: { value in
                    let newTheme: AppTheme = value ? .dark : .light
                    Task {
                        await authVM.updateTheme(newTheme)
                    }
                }
            ))
            .labelsHidden()
            .tint(.white)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: authVM.selectedTheme == .dark
                ? [.indigo, .purple]
                : [.blue, .cyan],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .purple.opacity(0.4), radius: 8)
    }

    
    var body: some View {
        ScrollView(showsIndicators: false) {

            if let profile = vm.profile {

                VStack(spacing: 28) {

                    ZStack {
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 30))

                        VStack(spacing: 12) {

                            Circle()
                                .frame(width: 100, height: 100)
                                .overlay(
                                    Image(profile.photoURL)
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                )


                            Text(profile.displayName)
                                .font(.title2.bold())
                                .foregroundColor(.white)

                            Text(profile.bio.isEmpty ? "Movie Lover 🎬" : profile.bio)
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.85))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top)

                    HStack(spacing: 16) {

                        statCard(
                            title: "Watchlist",
                            value: "\(profile.watchlist.count)",
                            icon: "bookmark.fill",
                            color: .blue
                        ) {
                            selectedTab = .watchlist
                        }

                        themeCard
                    }
                    VStack(alignment: .leading, spacing: 12) {

                        Text("Account")
                            .font(.headline)

                        HStack(spacing: 10) {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.blue)

                            Text(profile.email)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                    VStack(spacing: 14) {

                        Button {
                            isEditing = true
                        } label: {
                            Text("Edit Profile")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)

                        Button(role: .destructive) {
                            authVM.logout()
                        } label: {
                            Text("Logout")
                                .frame(maxWidth: .infinity)
                        }
                    }

                    Spacer(minLength: 40)
                }
                .padding()

            } else if vm.isLoading {

                ProgressView()
                    .padding(.top, 80)

            } else {

                Text("Profile not found")
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


    

func statCard(
    title: String,
    value: String,
    icon: String,
    color: Color,
    action: @escaping () -> Void
) -> some View {

    Button(action: action) {
        VStack(spacing: 8) {

            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.white)

            Text(value)
                .font(.title2.bold())
                .foregroundColor(.white)

            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            LinearGradient(
                colors: [color.opacity(0.9), color],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: color.opacity(0.4), radius: 8)
    }
    .buttonStyle(.plain)
}
    }


