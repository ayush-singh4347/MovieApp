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


    let onSave: (String, String) -> Void

    init(displayName: String, bio: String, onSave: @escaping (String, String) -> Void) {
        _displayName = State(initialValue: displayName)
        _bio = State(initialValue: bio)
        self.onSave = onSave
    }

    var body: some View {
        NavigationStack {
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
                        onSave(displayName, bio)
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

