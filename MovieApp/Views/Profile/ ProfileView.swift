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

    @State private var displayName = ""
    @State private var bio = ""
    @State private var email = ""
    @State private var watchlistCount = 0

    @State private var isEditing = false
    @State private var isLoading = true

    var body: some View {
        ScrollView {
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

                        Text(displayName)
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()

                        Text(bio)
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,16)
                    }
                }
                .padding(.top)

               
                HStack(spacing: 16) {
                    NavigationLink {
                            WatchlistView()
                        } label: {
                            statCard(
                                title: "Watchlist",
                                value: "\(watchlistCount)",
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
                        Text(email)
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
            }
            .padding()
        }
        .navigationTitle("Profile")
        .sheet(isPresented: $isEditing) {
            EditProfileView(
                displayName: displayName,
                bio: bio
            ) { newName, newBio in
                updateProfile(name: newName, bio: newBio)
            }
        }
        .task {
            await fetchProfile()
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

   

    func fetchProfile() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        do {
            let doc = try await Firestore.firestore()
                .collection("users")
                .document(uid)
                .getDocument()

            let data = doc.data() ?? [:]

            displayName = data["displayName"] as? String ?? ""
            bio = data["bio"] as? String ?? ""
            email = data["email"] as? String ?? ""

            let watchlist = data["watchlist"] as? [Int] ?? []
            watchlistCount = watchlist.count

            isLoading = false
        } catch {
            print("Profile fetch failed:", error)
        }
    }

    func updateProfile(name: String, bio: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Task {
            try await Firestore.firestore()
                .collection("users")
                .document(uid)
                .updateData([
                    "displayName": name,
                    "bio": bio
                ])

            self.displayName = name
            self.bio = bio
        }
    }
}
