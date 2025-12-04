//
//  ShoppingCart.swift
//  EnvironmentModifierDemo
//
//  Created by YEN-JU HUANG on 2025/12/4.
//

import Foundation
import SwiftUI

// ================================================
// APPROACH 2: Observable Object Syntax (iOS 17+)
// =================================================

// Use this approach for:
// - Shared mutable state
// - ViewModels
// - Services that need to be accessed across views
// - Complex objects with business logic

@Observable
class ShoppingCart {
    
    var items: [CartItem] = []
    
    var totoalPrice: Double {
        items.reduce(0) { $0 + $1.price * Double($1.quantity) }
    }
    
    var itemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
    
    static let mock = Product.mock
    
    static var mocks: [CartItem] = [
        CartItem(
            id: ShoppingCart.mock.id,
            name: ShoppingCart.mock.name,
            price: ShoppingCart.mock.price
        ),
        CartItem(
            id: ShoppingCart.mock.id,
            name: ShoppingCart.mock.name,
            price: ShoppingCart.mock.price
        ),
        CartItem(
            id: ShoppingCart.mock.id,
            name: ShoppingCart.mock.name,
            price: ShoppingCart.mock.price
        )
    ]
    
    func addItem(_ item: CartItem) {
        // if item alread existed
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity += 1
        } else {
            items.append(item)
        }
    }
    
    func removeItem(_ item: CartItem) {
        items.removeAll { $0.id == item.id }
    }
    
    func clearCart() {
        items.removeAll()
    }
}

struct CartItem: Identifiable, Equatable {
    let id: String
    let name: String
    let price: Double
    var quantity: Int = 1
}


