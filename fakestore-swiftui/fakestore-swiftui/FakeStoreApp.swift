//
//  FakeStoreApp.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import SwiftUI
import FirebaseCore

@main
struct FakeStoreApp: App {    
    let apiService = APIService.shared
    let productRepository: ProductRepositoryImpl
    let authRepository: AuthRepositoryImpl
    let cartRepository: CartRepositoryImpl
    
    let getProductsUseCase: GetProductsUseCase
    let getProductDetailsUseCase: GetProductDetailsUseCase
    
    let loginUseCase: LoginUseCase
    let logoutUseCase: LogoutUseCase
    let registerUseCase: RegisterUseCase
    
    let addToCartUseCase: AddToCartUseCase
    let observeCartUseCase: ObserveCartUseCase
    let updateCartQuantityUseCase: UpdateCartQuantityUseCase
    let removeFromCartUseCase: RemoveFromCartUseCase
    
    init() {
        FirebaseApp.configure()
        
        self.productRepository = ProductRepositoryImpl(apiService: apiService)
        self.authRepository = AuthRepositoryImpl()
        self.cartRepository = CartRepositoryImpl()
        
        self.getProductsUseCase = GetProductsUseCase(repository: productRepository)
        self.getProductDetailsUseCase = GetProductDetailsUseCase(repository: productRepository)
        
        self.loginUseCase = LoginUseCase(repository: authRepository)
        self.logoutUseCase = LogoutUseCase(repository: authRepository)
        self.registerUseCase = RegisterUseCase(repository: authRepository)
        
        self.addToCartUseCase = AddToCartUseCase(repository: cartRepository)
        self.observeCartUseCase = ObserveCartUseCase(repository: cartRepository)
        self.updateCartQuantityUseCase = UpdateCartQuantityUseCase(repository: cartRepository)
        self.removeFromCartUseCase = RemoveFromCartUseCase(repository: cartRepository)
    }
    
    var body: some Scene {
        WindowGroup {
            let loginVM = LoginViewModel(loginUseCase: loginUseCase)
            let registerVM = RegisterViewModel(registerUseCase: registerUseCase)
            let accountVM = AccountViewModel(logoutUseCase: logoutUseCase, authRepository: authRepository)
            
            let mainTab = MainTabView(
                getProductsUseCase: getProductsUseCase,
                getProductDetailsUseCase: getProductDetailsUseCase,
                addToCartUseCase: addToCartUseCase,
                observeCartUseCase: observeCartUseCase,
                updateCartQuantityUseCase: updateCartQuantityUseCase,
                removeFromCartUseCase: removeFromCartUseCase,
                accountViewModel: accountVM
            )
            
            RootView(
                loginViewModel: loginVM,
                registerViewModel: registerVM,
                mainTabView: mainTab
            )
        }
    }
}
