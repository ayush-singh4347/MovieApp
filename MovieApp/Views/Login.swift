//
//  Login.swift
//  MovieApp
//
//  Created by rentamac on 2/4/26.
//

import SwiftUI

struct LoginView: View {

    @State private var email = ""
    @State private var password = ""

    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        NavigationStack{
            ZStack {
                
                Color("backgroundColor")
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    
                    Image("login_illustration")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 180)
                    
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                    
                    VStack(spacing: 14) {
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color.primary.opacity(0.05))
                            .cornerRadius(10)
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.primary.opacity(0.05))
                            .cornerRadius(10)
                    }
                    
                    if let error = authVM.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    Button("Login") {
                        Task {
                            await authVM.login(email: email, password: password)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    HStack{
                        Text("Don’t have an account? ")
                        
                        NavigationLink("Sign Up") {
                            SignupView()
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
            }
        }
    }
}
