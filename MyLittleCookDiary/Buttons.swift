//
//  Buttons.swift
//  MyLittleCookDiary
//
//  Created by Ruby Kim on 2025-02-20.
//

import SwiftUI

struct Buttons: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Arial Rounded MT Bold", size: 18))
            .padding()
            .frame(maxWidth: 200, maxHeight: 50)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.pink, Color.yellow, Color.green, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .foregroundColor(.white)
            .cornerRadius(7)
            .shadow(radius: 5)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}
