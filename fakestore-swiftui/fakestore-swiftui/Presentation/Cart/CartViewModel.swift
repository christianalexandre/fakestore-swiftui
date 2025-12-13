//
//  CartViewModel.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 13/12/25.
//

import Foundation
import SwiftUI

@MainActor
class CartViewModel: ObservableObject {
    @Published var cartItems: [CartItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    var totalPrice: Double {
        cartItems.reduce(0) { $0 + $1.total }
    }
    
    private let observeCartUseCase: ObserveCartUseCaseProtocol
    private let updateCartQuantityUseCase: UpdateCartQuantityUseCaseProtocol
    private let removeFromCartUseCase: RemoveFromCartUseCaseProtocol
    
    init(observeCartUseCase: ObserveCartUseCaseProtocol,
         updateCartQuantityUseCase: UpdateCartQuantityUseCaseProtocol,
         removeFromCartUseCase: RemoveFromCartUseCaseProtocol) {
        self.observeCartUseCase = observeCartUseCase
        self.updateCartQuantityUseCase = updateCartQuantityUseCase
        self.removeFromCartUseCase = removeFromCartUseCase
    }
    
    func loadCart() {
        isLoading = true
        
        Task {
            for await items in observeCartUseCase.execute() {
                self.cartItems = items
                self.isLoading = false
            }
        }
    }
    
    func incrementQuantity(for item: CartItem) {
        Task {
            try? await updateCartQuantityUseCase.execute(productId: item.id, quantity: item.quantity + 1)
        }
    }
    
    func decrementQuantity(for item: CartItem) {
        Task {
            try? await updateCartQuantityUseCase.execute(productId: item.id, quantity: item.quantity - 1)
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let item = cartItems[index]
            Task {
                try? await removeFromCartUseCase.execute(productId: item.id)
            }
        }
    }
}
