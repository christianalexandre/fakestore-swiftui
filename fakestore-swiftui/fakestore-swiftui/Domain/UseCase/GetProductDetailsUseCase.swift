//
//  GetProductDetailsUseCaseProtocol.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//


import Foundation

protocol GetProductDetailsUseCaseProtocol {
    func execute(id: Int) async throws -> Product
}

class GetProductDetailsUseCase: GetProductDetailsUseCaseProtocol {
    private let repository: ProductRepositoryProtocol

    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }

    func execute(id: Int) async throws -> Product {
        return try await repository.getProduct(id: id)
    }
}