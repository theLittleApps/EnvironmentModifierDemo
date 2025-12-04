//
//  UserSession.swift
//  EnvironmentModifierDemo
//
//  Created by YEN-JU HUANG on 2025/12/4.
//

import Foundation
import SwiftUI

@Observable
class UserSession {
    var username: String = "Guest"
    var isLoggedIn: Bool = false
    var preferDarkMode: Bool = false
    
    func login(username: String) {
        self.username = username
        self.isLoggedIn = true
    }
    
    func logout() {
        self.username = "Guest"
        self.isLoggedIn = false
    }
}
