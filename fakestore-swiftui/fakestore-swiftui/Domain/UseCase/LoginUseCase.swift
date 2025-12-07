//
//  LoginUseCase.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import Foundation

protocol LoginUseCaseProtocol {
    func execute(email: String, password: String) async throws
}

class LoginUseCase: LoginUseCaseProtocol {
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(email: String, password: String) async throws {
        try await repository.login(email: email, password: password)
    }
}
