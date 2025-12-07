//
//  ProductListResponseDTO.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//


import Foundation

struct ProductListResponseDTO: Codable {
    let products: [ProductDTO]
    let total: Int
    let skip: Int
    let limit: Int
}

struct ProductDTO: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: String
    let discountPercentage: Double
    let rating: Double
    let category: String
    
    func toDomain() -> Product {
        return Product(
            id: id,
            title: title,
            description: description,
            price: price,
            thumbnail: thumbnail,
            discountPercentage: discountPercentage,
            rating: rating,
            category: category
        )
    }
}
