//
//  RegisterView.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//


import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel: RegisterViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            TextField("E-mail", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Confirm password", text: $viewModel.confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }
            
            Button(action: {
                Task { await viewModel.register() }
            }) {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Sign up")
                        .fontWeight(.bold)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            .disabled(viewModel.isLoading)
            
            Spacer()
        }
        .padding()
    }
}
