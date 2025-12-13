//
//  AccountViewModel.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//


import Foundation

@MainActor
class AccountViewModel: ObservableObject {
    @Published var userEmail: String = ""
    
    private let logoutUseCase: LogoutUseCaseProtocol
    private let authRepository: AuthRepositoryProtocol
    
    init(logoutUseCase: LogoutUseCaseProtocol, authRepository: AuthRepositoryProtocol) {
        self.logoutUseCase = logoutUseCase
        self.authRepository = authRepository
        loadCurrentUser()
    }
    
    func logout() {
        do {
            try logoutUseCase.execute()
        } catch {
            print("Logout error: \(error)")
        }
    }
    
    func loadCurrentUser() {
        self.userEmail = authRepository.getCurrentUserEmail() ?? "No user detected"
    }
}
