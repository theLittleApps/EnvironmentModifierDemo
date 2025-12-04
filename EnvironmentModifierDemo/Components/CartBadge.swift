//
//  CartBadge.swift
//  EnvironmentModifierDemo
//
//  Created by YEN-JU HUANG on 2025/12/4.
//

import SwiftUI

struct CartBadge: View {
    
    @Environment(ShoppingCart.self) private var cart
    @Environment(\.appAccentColor) private var accentColor
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "cart")
                .font(.title2)
            
            if cart.itemCount > 0 {
                Text("\(cart.itemCount)")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(4)
                    .background(accentColor)
                    .clipShape(Circle())
                    .offset(x: 8, y: -8)
            }
        }
    }
}

#Preview {
    CartBadge()
        .environment(ShoppingCart())
        .environment(\.appAccentColor, .orange)
}
