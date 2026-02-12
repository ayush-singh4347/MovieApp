//
//  VerificationPendingView.swift
//  MovieApp
//
//  Created by rentamac on 2/11/26.
//
import SwiftUI
import FirebaseAuth

struct VerificationPendingView: View {
    
    let user: User
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {

            Text("Verify Your Email")
                .font(.title)
                .bold()

            Text("A verification link was sent to \(user.email ?? "unknown")")
                .multilineTextAlignment(.center)

            Button("Resend Verification") {
                Task {
                    await authVM.resendVerificationEmail(user: user)
                }
            }

            Button("Back to Login") {
                Task{
                    try await user.reload()
                    if user.isEmailVerified {
                        authVM.authState = .unauthenticated
                    }
                }
            }
        }
        .padding()
    }
}
