//
//  LoginViewModel.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import Foundation
import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let loginUseCase: LoginUseCaseProtocol
    
    init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
    }
    
    func login() async {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Empty fields!"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            try await loginUseCase.execute(email: email, password: password)
        } catch {
            errorMessage = "Login error: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
