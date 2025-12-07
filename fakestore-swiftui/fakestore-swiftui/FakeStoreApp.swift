//
//  FakeStoreApp.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct FakeStoreApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let apiService = APIService.shared
    let productRepository: ProductRepositoryImpl
    let getProductsUseCase: GetProductsUseCase
    let getProductDetailsUseCase: GetProductDetailsUseCase
    
    init() {
        self.productRepository = ProductRepositoryImpl(apiService: apiService)
        self.getProductsUseCase = GetProductsUseCase(repository: productRepository)
        self.getProductDetailsUseCase = GetProductDetailsUseCase(repository: productRepository)
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView(
                getProductsUseCase: getProductsUseCase,
                getProductDetailsUseCase: getProductDetailsUseCase
            )
        }
    }
}
