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
    
    let accountViewModel: AccountViewModel
    
    var body: some View {
        TabView {
            ProductListView(
                viewModel: ProductListViewModel(getProductsUseCase: getProductsUseCase),
                getProductDetailsUseCase: getProductDetailsUseCase
            )
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            Text("Cart")
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
