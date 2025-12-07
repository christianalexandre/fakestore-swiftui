//
//  FakeStoreApp.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import SwiftUI

@main
struct FakeStoreApp: App {
    let apiService = APIService.shared
    let productRepository: ProductRepositoryImpl
    let getProductsUseCase: GetProductsUseCase
    
    init() {
        self.productRepository = ProductRepositoryImpl(apiService: apiService)
        self.getProductsUseCase = GetProductsUseCase(repository: productRepository)
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView(getProductsUseCase: getProductsUseCase)
        }
    }
}
