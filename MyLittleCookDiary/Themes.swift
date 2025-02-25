//
//  Themes.swift
//  MyLittleCookDiary
//
//  Created by Ruby Kim on 2025-02-20.
//

import Foundation
import SwiftUI

struct Themes {
    static let myPink = Color(red: 1.0, green: 0.85, blue: 0.9)    // Soft pastel pink
    static let myGreen = Color(red: 0.8, green: 1.0, blue: 0.8)    // Light pastel green
    static let myOrange = Color(red: 1.0, green: 0.8, blue: 0.6)   // Warm pastel orange
    
    static let myGradient = LinearGradient(gradient: Gradient(colors: [Themes.myPink, Themes.myGreen, Themes.myOrange, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    static let largeTitleFont = Font.custom("Arial Rounded MT Bold", size: 48)
    static let titleFont = Font.custom("Arial Rounded MT Bold", size: 20)
    static let bodyFont = Font.custom("Chalkboard SE", size: 18)
    static let captionFont = Font.custom("Chalkboard SE", size: 14)
}

extension View {
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        return self
    }
}
