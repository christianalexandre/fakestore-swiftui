//
//  ProductDetailViewModel.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import Foundation
import SwiftUI

@MainActor
class ProductDetailViewModel: ObservableObject {
    
    @Published var product: Product?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let getProductDetailsUseCase: GetProductDetailsUseCaseProtocol
    private let addToCartUseCase: AddToCartUseCaseProtocol
    
    init(getProductDetailsUseCase: GetProductDetailsUseCaseProtocol,
         addToCartUseCase: AddToCartUseCaseProtocol) {
        self.getProductDetailsUseCase = getProductDetailsUseCase
        self.addToCartUseCase = addToCartUseCase
    }
    
    func loadProduct(id: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedProduct = try await getProductDetailsUseCase.execute(id: id)
            self.product = fetchedProduct
        } catch {
            self.errorMessage = "Error loading product: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func addToCart() async {
            guard let product = product else { return }
            do {
                try await addToCartUseCase.execute(product: product)
            } catch {
                print("Error adding to cart: \(error)")
            }
        }
}
