//
//  RemoveFromCartUseCaseProtocol.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 13/12/25.
//

import Foundation

protocol RemoveFromCartUseCaseProtocol {
    func execute(productId: Int) async throws
}

class RemoveFromCartUseCase: RemoveFromCartUseCaseProtocol {
    private let repository: CartRepositoryProtocol

    init(repository: CartRepositoryProtocol) {
        self.repository = repository
    }

    func execute(productId: Int) async throws {
        try await repository.removeFromCart(productId: productId)
    }
}
