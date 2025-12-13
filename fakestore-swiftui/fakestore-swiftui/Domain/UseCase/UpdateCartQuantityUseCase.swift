//
//  UpdateCartQuantityUseCaseProtocol.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 13/12/25.
//

import Foundation

protocol UpdateCartQuantityUseCaseProtocol {
    func execute(productId: Int, quantity: Int) async throws
}

class UpdateCartQuantityUseCase: UpdateCartQuantityUseCaseProtocol {
    private let repository: CartRepositoryProtocol

    init(repository: CartRepositoryProtocol) {
        self.repository = repository
    }

    func execute(productId: Int, quantity: Int) async throws {
        try await repository.updateQuantity(productId: productId, quantity: quantity)
    }
}
