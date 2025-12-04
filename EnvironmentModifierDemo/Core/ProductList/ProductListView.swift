//
//  ProductListView.swift
//  EnvironmentModifierDemo
//
//  Created by YEN-JU HUANG on 2025/12/4.
//

import SwiftUI

struct ProductListView: View {
    
    // APPROACH 1: Reading from EnvironmentValues via KeyPath
    @Environment(\.appAccentColor) private var accentColor
    @Environment(\.cardCornerRadius) private var cornerRadius
    @Environment(\.isDebugMode) private var isDebugMode
    
    // APPROACH 2: Reading Observable objects via Type
    @Environment(ShoppingCart.self) private var cart
    @Environment(UserSession.self) private var session
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // Show debug info if enabled (using KeyPath environment value)
                    if isDebugMode {
                        DebugInfoCard()
                    }
                    
                    // Welcome message (using Observable environment object)
                    WelcomeHeader()
                    
                    // Product Grid
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(Product.mocks) { product in
                            ProductCard(product: product)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Shop")
            .toolbar {
                if #available(iOS 26.0, *) {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        // show cart badage
                        CartBadge()
                    }
                    .sharedBackgroundVisibility(.hidden)
                } else {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        // show cart badage
                        CartBadge()
                    }
                }
            }
        }
    }
}

#Preview {
    ProductListView()
        .environment(\.appAccentColor, .orange)
        .environment(\.cardCornerRadius, 16)
        .environment(\.isDebugMode, true)
        .environment(ShoppingCart())
        .environment(UserSession())
}

