//
//  CartView.swift
//  EnvironmentModifierDemo
//
//  Created by YEN-JU HUANG on 2025/12/4.
//

import SwiftUI

struct CartView: View {
    
    @Environment(ShoppingCart.self) private var cart
    @Environment(\.appAccentColor) private var accentColor
    @Environment(\.cardCornerRadius) private var cornerRadius
    
    private let items: [CartItem] = ShoppingCart.mocks
    
    var body: some View {
        NavigationStack {
            Group {
                if cart.items.isEmpty {
                    ContentUnavailableView(
                        "Your cart is empty",
                        image: "cart",
                        description: Text("Add some items to get started!")
                    )
                } else {
                    List {
                        ForEach(cart.items) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    Text("$\(item.price, specifier: "%.2f") × \(item.quantity)")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                Text("$\(item.price * Double(item.quantity), specifier: "%.2f")")
                                    .fontWeight(.semibold)
                            }
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                cart.removeItem(cart.items[index])
                            }
                        }
                        
                        Section {
                            HStack {
                                Text("Total")
                                    .font(.headline)
                                
                                Spacer()
                                
                                Text("$\(cart.totoalPrice, specifier: "%.2f")")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(accentColor)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Cart")
            .toolbar {
                if !cart.items.isEmpty {
                    Button("Clear") {
                        cart.clearCart()
                    }
                    .foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    CartView()
        .environment(ShoppingCart())
        .environment(\.appAccentColor, .orange)
        .environment(\.cardCornerRadius, 16)
}
