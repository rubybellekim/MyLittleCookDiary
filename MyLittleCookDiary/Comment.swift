//
//  Comment.swift
//  MyLittleCookDiary
//
//  Created by Ruby Kim on 2025-02-25.
//

import Foundation
import SwiftData

@Model
class Comment {
    var id: UUID
    var text: String
    var date: Date
    var cook: Cook?

    init(text: String, cook: Cook? = nil) {
        self.id = UUID()
        self.text = text
        self.date = Date()
        self.cook = cook
    }
}
