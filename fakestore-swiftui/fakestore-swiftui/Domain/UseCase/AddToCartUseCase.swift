//
//  AddToCartUseCaseProtocol.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 13/12/25.
//


import Foundation

protocol AddToCartUseCaseProtocol {
    func execute(product: Product) async throws
}

class AddToCartUseCase: AddToCartUseCaseProtocol {
    private let repository: CartRepositoryProtocol

    init(repository: CartRepositoryProtocol) {
        self.repository = repository
    }

    func execute(product: Product) async throws {
        try await repository.addToCart(product: product)
    }
}