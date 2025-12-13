//
//  CartRepositoryImpl.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 13/12/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class CartRepositoryImpl: CartRepositoryProtocol {
    
    private let db = Firestore.firestore()
    
    private var cartCollection: CollectionReference? {
        guard let userId = Auth.auth().currentUser?.uid else { return nil }
        return db.collection("users").document(userId).collection("cart")
    }
    
    func addToCart(product: Product) async throws {
        guard let collection = cartCollection else {
            throw NSError(domain: "Auth", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }
        
        let document = collection.document(String(product.id))
        
        let data: [String: Any] = [
            "productId": product.id,
            "title": product.title,
            "price": product.price,
            "thumbnail": product.thumbnail,
            "quantity": FieldValue.increment(Int64(1))
        ]
        
        try await document.setData(data, merge: true)
    }
    
    func removeFromCart(productId: Int) async throws {
        guard let collection = cartCollection else { return }
        try await collection.document(String(productId)).delete()
    }
    
    func updateQuantity(productId: Int, quantity: Int) async throws {
        guard let collection = cartCollection else { return }
        
        if quantity <= 0 {
            try await removeFromCart(productId: productId)
        } else {
            try await collection.document(String(productId)).updateData([
                "quantity": quantity
            ])
        }
    }
    
    func listenToCart() -> AsyncStream<[CartItem]> {
        return AsyncStream { continuation in
            guard let collection = cartCollection else {
                continuation.finish()
                return
            }
            
            let listener = collection.addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error listening to cart: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    continuation.yield([])
                    return
                }
                
                let items = documents.compactMap { doc -> CartItem? in
                    try? doc.data(as: CartItem.self)
                }
                
                let sortedItems = items.sorted { $0.id < $1.id }
                continuation.yield(sortedItems)
            }

            continuation.onTermination = { _ in
                listener.remove()
            }
        }
    }
}
