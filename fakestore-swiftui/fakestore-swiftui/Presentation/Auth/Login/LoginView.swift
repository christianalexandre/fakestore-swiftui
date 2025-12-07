//
//  LoginView.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel

    let registerViewModel: RegisterViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("FakeStore Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                TextField("E-mail", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button(action: {
                    Task { await viewModel.login() }
                }) {
                    if viewModel.isLoading {
                        ProgressView().tint(.white)
                    } else {
                        Text("Sign in")
                            .fontWeight(.bold)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(viewModel.isLoading)
                Spacer().frame(height: 20)
                
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.secondary)
                    
                    NavigationLink(destination: RegisterView(viewModel: registerViewModel)) {
                        Text("Sign up")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}
