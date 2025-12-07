//
//  RegisterUseCase.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//


protocol RegisterUseCaseProtocol {
    func execute(email: String, password: String) async throws
}

class RegisterUseCase: RegisterUseCaseProtocol {
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(email: String, password: String) async throws {
        try await repository.register(email: email, password: password)
    }
}
