//
//  EnvironmentModifierDemoApp.swift
//  EnvironmentModifierDemo
//
//  Created by YEN-JU HUANG on 2025/12/4.
//

import SwiftUI

// ========================================
//  APP ENTRY POINT
// ========================================

@main
struct EnvironmentModifierDemoApp: App {
    
    // Observable objects are created at the app top level
    @State private var cart = ShoppingCart()
    @State private var userSession = UserSession()
    
    var body: some Scene {
        WindowGroup {
            // SwiftUI's dependency injection using environment modifier
            ContentView()
                // APPROACH 1: KeyPath syntax for EnvironmentValues
                .environment(\.appAccentColor, .orange)
                .environment(\.cardCornerRadius, 16)
                .environment(\.isDebugMode, true)
            
                // APPROACH 2: Observable object syntax
                .environment(cart)
                .environment(userSession)
        }
    }
}
