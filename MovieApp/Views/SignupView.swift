//
//  SignupView.swift
//  MovieApp
//
//  Created by rentamac on 2/5/26.
//

import SwiftUI

struct SignupView: View {

    @State private var email = ""
    @State private var password = ""

    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {

            
            Color("backgroundColor")
                .ignoresSafeArea()

            VStack(spacing: 20) {

                Spacer()

                
                Image("login_illustration")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 180)

                Text("Create Account")
                    .font(.largeTitle)
                    .bold()

                VStack(spacing: 14) {

                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding()
                        .background(Color.primary.opacity(0.05))
                        .cornerRadius(10)

                    SecureField("Password (min 6 chars)", text: $password)
                        .padding()
                        .background(Color.primary.opacity(0.05))
                        .cornerRadius(10)
                }

                if let error = authVM.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button {
                    Task {
                        await authVM.signup(
                            email: email,
                            password: password
                        )
                        if authVM.user != nil{
                            dismiss()
                        }
                    }
                } label: {
                    Text("Sign Up")
                        
                }
                .buttonStyle(.borderedProminent)

                
                HStack{
                    Text("Already have an account?")
                    
                    Button(" Login") {
                        dismiss()
                    }
                   
                }
                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true)
    }
}
