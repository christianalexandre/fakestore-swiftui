//
//  CartView.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 13/12/25.
//

import SwiftUI

struct CartView: View {
    @StateObject var viewModel: CartViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.cartItems.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "cart.badge.minus")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("Your cart is empty")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(viewModel.cartItems) { item in
                            CartItemRow(
                                item: item,
                                onIncrement: { viewModel.incrementQuantity(for: item) },
                                onDecrement: { viewModel.decrementQuantity(for: item) }
                            )
                        }
                        .onDelete(perform: viewModel.deleteItem)
                    }
                    .listStyle(.plain)
                    
                    VStack(spacing: 16) {
                        Divider()
                        
                        HStack {
                            Text("Total")
                                .font(.title3)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("$\(String(format: "%.2f", viewModel.totalPrice))")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal)
                        
                        Button(action: {
                            print("checkout action")
                        }) {
                            Text("Checkout")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .background(Color(UIColor.systemBackground))
                }
            }
            .onAppear {
                viewModel.loadCart()
            }
        }
    }
}
