//
//  ForgetPasswordView.swift
//  MovieApp
//
//  Created by rentamac on 2/12/26.
//
import SwiftUI

struct ForgotPasswordView: View {

    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var email = ""

    var body: some View {
        VStack(spacing: 24) {

            Spacer()

            Text("Reset Password")
                .font(.title)
                .bold()

            Text("Enter your email to receive a password reset link.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .padding()
                .background(Color.primary.opacity(0.05))
                .cornerRadius(12)

            if let message = authVM.infoMessage {
                Text(message)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Button("Send Reset Link") {
                Task {
                    await authVM.resetPassword(email: email)
                }
            }
            .buttonStyle(.borderedProminent)

            Button("Back to Login") {
                dismiss()
            }

            Spacer()
        }
        .padding()
    }
}

