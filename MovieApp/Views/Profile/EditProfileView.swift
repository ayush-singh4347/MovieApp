//
//  EditProfileView.swift
//  MovieApp
//
//  Created by rentamac on 2/9/26.
//
import SwiftUI

struct EditProfileView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var displayName: String
    @State private var bio: String
    @State private var selectedAvatar: String


    let onSave: (String, String, String) -> Void

    init(displayName: String, bio: String, photoURL:String, onSave: @escaping (String, String, String) -> Void) {
        _displayName = State(initialValue: displayName)
        _bio = State(initialValue: bio)
        _selectedAvatar = State(initialValue: photoURL)
        self.onSave = onSave
    }

    var body: some View {
        NavigationStack {
            Section("Choose Avatar") {

                let avatars = [
                    "avatar_girl1",
                    "avatar_girl2",
                    "avatar_girl3",
                    "avatar_girl4",
                    "avatar_boy1",
                    "avatar_boy2",
                    "avatar_boy3",
                    "avatar_boy4",
                    "avatar_boy5"
                ]

                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible()), count: 3),
                    spacing: 16
                ) {
                    ForEach(avatars, id: \.self) { avatar in
                        Image(avatar)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(
                                        selectedAvatar == avatar ? Color.blue : Color.clear,
                                        lineWidth: 3
                                    )
                            )
                            .onTapGesture {
                                selectedAvatar = avatar
                            }
                    }
                }
            }

            Form {
                Section("Profile") {
                    TextField("Display Name", text: $displayName)
                    TextField("Bio", text: $bio)
                }
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(displayName, bio, selectedAvatar)
                        dismiss()
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            
        }
    }
}

