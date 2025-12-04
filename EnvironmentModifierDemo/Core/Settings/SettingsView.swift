//
//  SettingsView.swift
//  EnvironmentModifierDemo
//
//  Created by YEN-JU HUANG on 2025/12/4.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(UserSession.self) private var session
    @Environment(\.appAccentColor) private var accentColor
    
    var body: some View {
        NavigationStack {
            List {
                Section("Account") {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(accentColor)
                        
                        VStack(alignment: .leading) {
                            Text(session.username)
                                .font(.headline)
                            
                            Text(session.isLoggedIn ? "Signed In" : "Guest")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                        }
                    }
                    .padding(.vertical, 4)
                    
                    if session.isLoggedIn {
                        Button("Sign Out", role: .destructive) {
                            session.logout()
                        }
                    } else {
                        Button("Sign In") {
                            session.login(username: "JIMMY HUANG")
                        }
                    }
                }
                
                Section("About This Demo") {
                    VStack (alignment: .leading, spacing: 12) {
                        Text("Environment Modifier")
                            .font(.headline)
                        
                        Text(
                            """
                            This demo shows two ways to use .environment():
                            
                            **1. KeyPath Syntax**
                            `.environment(\\.key, value)`
                            
                            **2. Observable Syntax**
                            `.environment(object)`
                            For @Observable classes - shared state, ViewModels
                            """
                        )
                        .font(.caption)
                    }
                    .padding(.vertical, 8)
                    
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
        .environment(UserSession())
        .environment(\.appAccentColor, .orange)
}
