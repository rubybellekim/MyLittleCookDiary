//
//  RatingView.swift
//  MyLittleCookDiary
//
//  Created by Ruby Kim on 2025-02-19.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "fish.fill")
    
    var offColor = Color.gray
    var onColor = [Color.pink, Color.yellow, Color.green, Color.blue,  Color.purple]
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                Button {
                    rating = number
                } label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor[number - 1])
                }
            }
        }
        //button in the same row binding together in default,
        //by add this, we can make each button works different.
        .buttonStyle(.plain)
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(5))
}
