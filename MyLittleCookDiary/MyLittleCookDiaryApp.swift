//
//  MyLittleCookDiaryApp.swift
//  MyLittleCookDiary
//
//  Created by Ruby Kim on 2025-02-18.
//

import SwiftUI
import SwiftData

@main
struct MyLittleCookDiaryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Cook.self)
    }
}
