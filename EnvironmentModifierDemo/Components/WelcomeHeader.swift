//
//  WelcomeHeader.swift
//  EnvironmentModifierDemo
//
//  Created by YEN-JU HUANG on 2025/12/4.
//

import SwiftUI

struct WelcomeHeader: View {
    
    @Environment(UserSession.self) private var session
    @Environment(\.appAccentColor) private var accentColor
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Welcome back,")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(session.username)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            if !session.isLoggedIn {
                Button("Sign In") {
                    session.login(username: "JIMMY HUANG")
                }
                .buttonStyle(.borderedProminent)
                .tint(accentColor)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

#Preview {
    WelcomeHeader()
        .environment(\.appAccentColor, .orange)
        .environment(UserSession())
}
