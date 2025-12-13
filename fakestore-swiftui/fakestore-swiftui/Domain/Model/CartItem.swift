//
//  CartItem.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 13/12/25.
//

import Foundation

struct CartItem: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let price: Double
    let thumbnail: String
    var quantity: Int
    
    var total: Double {
        return price * Double(quantity)
    }
    
    enum CodingKeys: String, CodingKey {
            case id = "productId"
            case title
            case price
            case quantity
            case thumbnail
        }
}
