//
//  DebugInfoCard.swift
//  EnvironmentModifierDemo
//
//  Created by YEN-JU HUANG on 2025/12/4.
//

import SwiftUI

struct DebugInfoCard: View {
    
    // APPROACH 1: Reading from EnvironmentValues via KeyPath
    @Environment(\.appAccentColor) private var accentColor
    @Environment(\.cardCornerRadius) private var cornerRadius
    @Environment(\.isDebugMode) private var isDebugMode
    @Environment(ShoppingCart.self) private var cart
    @Environment(UserSession.self) private var session
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Debug Mode", systemImage: "ladybug")
                .font(.headline)
                .foregroundStyle(.orange)
            
            Divider()
            
            Group {
                // markdown format
                Text("**KeyPath Values (EnvironmentValues):**")
                Text("• Accent Color: \(accentColor.description)")
                Text("• Corner Radius: \(cornerRadius, specifier: "%.0f")")
                
                Text("**Observable Objects:**")
                Text("• Cart Items: \(cart.itemCount)")
                Text("• User: \(session.username)")
                Text("• Logged In: \(session.isLoggedIn ? "Yes" : "No")")
                
            }
            .font(.caption)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.orange.opacity(0.1))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.orange, lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

#Preview {
    DebugInfoCard()
        .environment(\.appAccentColor, .orange)
        .environment(\.cardCornerRadius, 16)
        .environment(\.isDebugMode, true)
        .environment(ShoppingCart())
        .environment(UserSession())
}
