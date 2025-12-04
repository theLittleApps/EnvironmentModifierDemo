//
//  ProductCard.swift
//  EnvironmentModifierDemo
//
//  Created by YEN-JU HUANG on 2025/12/4.
//

import SwiftUI

// Demonstrates reading BOTH types of environment values
struct ProductCard: View {
    
    let product: Product
    
    // KeyPath syntax: simple configuration values
    @Environment(\.appAccentColor) private var accentColor
    @Environment(\.cardCornerRadius) private var cornerRadius
    
    // Observable syntax: shared mutable state
    @Environment(ShoppingCart.self) private var cart
    
    var body: some View {
        VStack(spacing: 8) {
            Text(product.emoji)
                .font(.system(size: 44))
            
            Text(product.name)
                .font(.headline)
            
            Text("$\(product.price, specifier: "%.2f")")
            
            Button {
                cart.addItem(
                    CartItem(
                        id: product.id,
                        name: product.name,
                        price: product.price
                    )
                )
            } label: {
                Text("Add to Cart")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(accentColor))
                    .clipShape(Capsule())
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
        
    }
}

#Preview {
    ProductCard(product: Product.mock)
        .environment(\.appAccentColor, .orange)
        .environment(\.cardCornerRadius, 16)
        .environment(ShoppingCart())
        .padding(20)
}
