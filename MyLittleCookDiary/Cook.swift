//
//  Cook.swift
//  MyLittleCookDiary
//
//  Created by Ruby Kim on 2025-02-19.
//

import Foundation
import SwiftData



@Model
class Cook {
    var title: String
    var genre: String
    var review: String
    var rating: Int
    var imageData: Data?
    var dateAdded: Date?
    
    @Relationship(deleteRule: .cascade) // Deletes comments when the cook is deleted
        var comments: [Comment] = []
        
    init(title: String, genre: String, review: String, rating: Int, imageData: Data? = nil, dateAdded: Date? = nil) {
        self.title = title
        self.genre = genre
        self.review = review
        self.rating = rating
        self.imageData = imageData
        self.dateAdded = dateAdded ?? Date()
    }
}


#imageLiteral(resourceName: "simulator_screenshot_A77DCF2A-A2D9-4208-936C-798FACF55844.png")
