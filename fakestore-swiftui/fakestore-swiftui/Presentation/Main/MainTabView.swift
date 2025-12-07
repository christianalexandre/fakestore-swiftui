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
    
    var body: some View {
        TabView {
            ProductListView(
                viewModel: ProductListViewModel(getProductsUseCase: getProductsUseCase),
                getProductDetailsUseCase: getProductDetailsUseCase
            )
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            Text("Carrinho (Em breve)")
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
            
            Text("Conta (Em breve)")
                .tabItem {
                    Label("Account", systemImage: "person.circle.fill")
                }
        }
    }
}
