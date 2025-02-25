//
//  CookView.swift
//  MyLittleCookDiary
//
//  Created by Ruby Kim on 2025-02-24.
//

import SwiftUI

struct CookView: View {
    let cook: Cook

    var body: some View {
        NavigationLink(value: cook) {
            HStack {
                EmojiRatingView(rating: cook.rating)
                    .font(.headline)
                VStack(alignment: .leading) {
                    Text(cook.title)
                        .font(Themes.bodyFont)
                }
            }
        }
    }
}
