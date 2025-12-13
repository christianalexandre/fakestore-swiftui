//
//  CartItemRow.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 13/12/25.
//

import SwiftUI

struct CartItemRow: View {
    let item: CartItem
    let onIncrement: () -> Void
    let onDecrement: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: item.thumbnail)) { image in
                image.resizable().aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray.opacity(0.1)
            }
            .frame(width: 70, height: 70)
            .cornerRadius(8)
            .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                    .lineLimit(1)
                
                Text("$\(String(format: "%.2f", item.price))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack(spacing: 12) {
                Button(action: onDecrement) {
                    Image(systemName: "minus.circle")
                }
                .buttonStyle(.plain)
                
                Text("\(item.quantity)")
                    .font(.headline)
                    .frame(minWidth: 20)
                
                Button(action: onIncrement) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 4)
    }
}
