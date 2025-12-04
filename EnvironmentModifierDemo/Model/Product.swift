//
//  Product.swift
//  EnvironmentModifierDemo
//
//  Created by YEN-JU HUANG on 2025/12/4.
//

import Foundation

// ========================================
//  SAMPLE PRODUCTS DATA
// ========================================

struct Product: Identifiable {
    let id: String
    let name: String
    let price: Double
    let emoji: String
    
    static var mock: Product {
        Product.mocks.first!
    }
    
    static var mocks: [Product] = [
        Product(id: "1", name: "Coffee", price: 4.99, emoji: "☕️"),
        Product(id: "2", name: "Croissant", price: 3.49, emoji: "🥐"),
        Product(id: "3", name: "Sandwich", price: 8.99, emoji: "🥪"),
        Product(id: "4", name: "Salad", price: 7.49, emoji: "🥗"),
    ]
}
