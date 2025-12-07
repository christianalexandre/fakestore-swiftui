//
//  ProductRowView.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import SwiftUI

struct ProductRowView: View {
    let product: Product
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: product.thumbnail)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if phase.error != nil {
                    Color.gray.opacity(0.3)
                        .overlay(Image(systemName: "photo").foregroundColor(.gray))
                } else {
                    ProgressView()
                }
            }
            .frame(width: 80, height: 80)
            .cornerRadius(8)
            .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                
                Text(product.category.capitalized)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 3) {
                    Image(systemName: "star.fill")
                        .font(.caption2)
                        .foregroundColor(.yellow)
                    
                    Text(String(format: "%.1f", product.rating))
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("$\(String(format: "%.2f", product.price))")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                if product.discountPercentage > 0 {
                    Text("-\(Int(product.discountPercentage))%")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(Color.red)
                        .cornerRadius(4)
                }
            }
        }
        .padding(.vertical, 4)
        .frame(height: 80)
    }
}
