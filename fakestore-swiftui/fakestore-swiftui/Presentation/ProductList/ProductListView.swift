//
//  ProductListView.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel: ProductListViewModel
    
    let getProductDetailsUseCase: GetProductDetailsUseCaseProtocol
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.products) { product in
                    NavigationLink(
                        destination: ProductDetailView(
                            productId: product.id,
                            viewModel: ProductDetailViewModel(
                                getProductDetailsUseCase: getProductDetailsUseCase
                            )
                        )
                    ) {
                        ProductRowView(product: product)
                            .onAppear {
                                viewModel.loadMoreContentIfNeeded(currentItem: product)
                            }
                    }
                    .padding(.vertical, 4)
                }
                
                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
            .task {
                if viewModel.products.isEmpty {
                    await viewModel.loadProducts()
                }
            }
        }
    }
}
