//
//  ProductDetailView.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import SwiftUI

struct ProductDetailView: View {
    let productId: Int
    @StateObject var viewModel: ProductDetailViewModel
    
    var body: some View {
        ScrollView {
            if let product = viewModel.product {
                VStack(alignment: .leading, spacing: 16) {
                    if !product.images.isEmpty {
                        TabView {
                            ForEach(product.images, id: \.self) { imageUrl in
                                AsyncImage(url: URL(string: imageUrl)) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    } else {
                                        ProgressView()
                                    }
                                }
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(height: 300)
                        .background(Color(.systemGray6))
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(product.brand ?? "")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                            .textCase(.uppercase)
                        
                        Text(product.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        HStack {
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text(String(format: "%.1f", product.rating))
                                    .fontWeight(.medium)
                            }
                            
                            Spacer()
                            
                            if product.stock > 0 {
                                Text("\(product.stock) in stock")
                                    .font(.caption)
                                    .foregroundColor(.green)
                            } else {
                                Text("Out of stock")
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Divider()
                        
                        Text("Description")
                            .font(.headline)
                        
                        Text(product.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineSpacing(4)
                        
                        Divider()
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Price")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                HStack(alignment: .firstTextBaseline, spacing: 8) {
                                    Text("$\(String(format: "%.2f", product.price))")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                    
                                    if product.discountPercentage > 0 {
                                        Text("-\(Int(product.discountPercentage))%")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .padding(6)
                                            .background(Color.red.opacity(0.1))
                                            .foregroundColor(.red)
                                            .cornerRadius(4)
                                    }
                                }
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                // TODO: Implement Firestore Logic
                                print("Add to cart clicked")
                            }) {
                                Text("Add to Cart")
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                            .frame(width: 160)
                        }
                        .padding(.top, 8)
                    }
                    .padding(.horizontal)
                }
            } else if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 100)
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .task {
            await viewModel.loadProduct(id: productId)
        }
    }
}
