//
//  MainTabView.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//


import SwiftUI

struct MainTabView: View {
    let getProductsUseCase: GetProductsUseCaseProtocol
    let getProductDetailsUseCase: GetProductDetailsUseCaseProtocol
    
    let addToCartUseCase: AddToCartUseCaseProtocol
    let observeCartUseCase: ObserveCartUseCaseProtocol
    let updateCartQuantityUseCase: UpdateCartQuantityUseCaseProtocol
    let removeFromCartUseCase: RemoveFromCartUseCaseProtocol
    
    let accountViewModel: AccountViewModel
    
    var body: some View {
        TabView {
            ProductListView(
                viewModel: ProductListViewModel(getProductsUseCase: getProductsUseCase),
                getProductDetailsUseCase: getProductDetailsUseCase,
                addToCartUseCase: addToCartUseCase
            )
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            CartView(viewModel: CartViewModel(
                observeCartUseCase: observeCartUseCase,
                updateCartQuantityUseCase: updateCartQuantityUseCase,
                removeFromCartUseCase: removeFromCartUseCase
            ))
            .tabItem {
                Label("Cart", systemImage: "cart.fill")
            }
            
            AccountView(viewModel: accountViewModel)
                .tabItem {
                    Label("Account", systemImage: "person.circle.fill")
                }
        }
    }
}
