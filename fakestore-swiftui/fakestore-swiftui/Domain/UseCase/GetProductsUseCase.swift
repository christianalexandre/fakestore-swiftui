//
//  GetProductsUseCaseProtocol.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import Foundation

protocol GetProductsUseCaseProtocol {
    func execute(limit: Int, skip: Int) async throws -> (products: [Product], total: Int)
}

class GetProductsUseCase: GetProductsUseCaseProtocol {
    private let repository: ProductRepositoryProtocol

    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }

    func execute(limit: Int, skip: Int) async throws -> (products: [Product], total: Int) {
        return try await repository.getProducts(limit: limit, skip: skip)
    }
}
