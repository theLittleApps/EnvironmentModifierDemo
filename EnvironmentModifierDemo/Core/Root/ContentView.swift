//
//  ContentView.swift
//  EnvironmentModifierDemo
//
//  Created by YEN-JU HUANG on 2025/12/4.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ProductListView()
                .tabItem {
                    Label("Shop", systemImage: "storefront")
                }
            
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview("Debug mode is true") {
    ContentView()
        .environment(\.appAccentColor, .orange)
        .environment(\.cardCornerRadius, 16)
        .environment(\.isDebugMode, true)
        .environment(ShoppingCart())
        .environment(UserSession())
}

#Preview("Debug mode is false") {
    ContentView()
        .environment(\.appAccentColor, .orange)
        .environment(\.cardCornerRadius, 16)
        .environment(\.isDebugMode, false)
        .environment(ShoppingCart())
        .environment(UserSession())
}
