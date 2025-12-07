//
//  ProductListViewModel.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import Foundation
import SwiftUI

@MainActor
class ProductListViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var totalItems: Int = 0
    private let limit: Int = 20
    private var canLoadMore: Bool = true
    
    private let getProductsUseCase: GetProductsUseCaseProtocol
    
    init(getProductsUseCase: GetProductsUseCaseProtocol) {
        self.getProductsUseCase = getProductsUseCase
    }
    
    func loadProducts() async {
        guard !isLoading && canLoadMore else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let currentCount = products.count
            let (newProducts, total) = try await getProductsUseCase.execute(limit: limit, skip: currentCount)
            
            self.products.append(contentsOf: newProducts)
            self.totalItems = total
            
            self.canLoadMore = products.count < totalItems
        } catch {
            self.errorMessage = "Erro ao carregar: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func loadMoreContentIfNeeded(currentItem item: Product) {
        let thresholdIndex = products.index(products.endIndex, offsetBy: -3)
        if products.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            Task {
                await loadProducts()
            }
        }
    }
}
