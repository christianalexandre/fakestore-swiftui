//
//  LogoutUseCase.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import Foundation

protocol LogoutUseCaseProtocol {
    func execute() throws
}

class LogoutUseCase: LogoutUseCaseProtocol {
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() throws {
        try repository.logout()
    }
}
