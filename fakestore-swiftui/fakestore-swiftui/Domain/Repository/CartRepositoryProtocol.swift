//
//  CartRepositoryProtocol.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 13/12/25.
//

import Foundation

protocol CartRepositoryProtocol {
    func addToCart(product: Product) async throws
    func removeFromCart(productId: Int) async throws
    func updateQuantity(productId: Int, quantity: Int) async throws
    func listenToCart() -> AsyncStream<[CartItem]>
}
