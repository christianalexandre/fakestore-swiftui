//
//  ProductRepositoryImpl.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import Foundation

class ProductRepositoryImpl: ProductRepositoryProtocol {
    private let apiService: APIService

    init(apiService: APIService = APIService.shared) {
        self.apiService = apiService
    }

    func getProducts(limit: Int, skip: Int) async throws -> (products: [Product], total: Int) {
        let (dtos, total) = try await apiService.fetchProducts(limit: limit, skip: skip)
        let domainProducts = dtos.map { $0.toDomain() }
        
        return (products: domainProducts, total: total)
    }

    func getProduct(id: Int) async throws -> Product {
        let dto = try await apiService.fetchProduct(id: id)
        return dto.toDomain()
    }
}
