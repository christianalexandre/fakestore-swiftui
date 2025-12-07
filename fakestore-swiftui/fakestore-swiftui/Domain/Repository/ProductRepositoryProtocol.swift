//
//  ProductRepositoryProtocol.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import Foundation

protocol ProductRepositoryProtocol {
    func getProducts(limit: Int, skip: Int) async throws -> (products: [Product], total: Int)
    func getProduct(id: Int) async throws -> Product
}
