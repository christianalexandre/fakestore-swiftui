//
//  RegisterViewModel.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//


import Foundation

@MainActor
class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let registerUseCase: RegisterUseCaseProtocol
    
    init(registerUseCase: RegisterUseCaseProtocol) {
        self.registerUseCase = registerUseCase
    }
    
    func register() async {
        // Validações básicas
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "Preencha todos os campos"
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = "As senhas não conferem"
            return
        }
        
        guard password.count >= 6 else {
            errorMessage = "A senha deve ter no mínimo 6 caracteres"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            try await registerUseCase.execute(email: email, password: password)
        } catch {
            errorMessage = "Erro no registro: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
