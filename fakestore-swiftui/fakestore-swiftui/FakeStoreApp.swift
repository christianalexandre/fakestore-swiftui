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
    let authRepository: AuthRepositoryImpl
    
    let getProductsUseCase: GetProductsUseCase
    let getProductDetailsUseCase: GetProductDetailsUseCase
    let loginUseCase: LoginUseCase
    let logoutUseCase: LogoutUseCase
    let registerUseCase: RegisterUseCase
    
    init() {
        self.productRepository = ProductRepositoryImpl(apiService: apiService)
        self.authRepository = AuthRepositoryImpl()
        
        self.getProductsUseCase = GetProductsUseCase(repository: productRepository)
        self.getProductDetailsUseCase = GetProductDetailsUseCase(repository: productRepository)
        self.loginUseCase = LoginUseCase(repository: authRepository)
        self.logoutUseCase = LogoutUseCase(repository: authRepository)
        self.registerUseCase = RegisterUseCase(repository: authRepository)
    }
    
    var body: some Scene {
        WindowGroup {
            let loginVM = LoginViewModel(loginUseCase: loginUseCase)
            let registerVM = RegisterViewModel(registerUseCase: registerUseCase)
            
            let accountVM = AccountViewModel(
                logoutUseCase: logoutUseCase,
                authRepository: authRepository
            )
            
            let mainTab = MainTabView(
                getProductsUseCase: getProductsUseCase,
                getProductDetailsUseCase: getProductDetailsUseCase,
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
