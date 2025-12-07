//
//  Product.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import Foundation

struct Product: Identifiable, Equatable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: String
    let discountPercentage: Double
    let rating: Double
    let category: String
}
