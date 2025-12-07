//
//  ProductListView.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel: ProductListViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.products) { product in
                    ProductRowView(product: product)
                        .onAppear {
                            viewModel.loadMoreContentIfNeeded(currentItem: product)
                        }
                }
                
                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
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
