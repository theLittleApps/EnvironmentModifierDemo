//
//  EnvironmentValues+Ext.swift
//  EnvironmentModifierDemo
//
//  Created by YEN-JU HUANG on 2025/12/4.
//
// ================================================
// APPROACH 1: KeyPath Syntax (EnvironmentValues)
// ================================================
//
// Use this approach for:
// - App-wide configuration settings
// - Theming (colors, fonts, spacing)
// - Feature flags
// - Simple value types

import Foundation
import SwiftUI

// Define custom environment values using @Entry
extension EnvironmentValues {
    @Entry var appAccentColor: Color = .blue
    @Entry var cardCornerRadius: CGFloat = 12
    @Entry var isDebugMode: Bool = false
}
