//
//  DetailView.swift
//  MyLittleCookDiary
//
//  Created by Ruby Kim on 2025-02-19.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var showingDeleteAlert = false
    @State private var showingCommentSheet = false
    
    let cook: Cook
            
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                if let imageData = cook.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .cornerRadius(10)
                        .padding()
                } else {
                    //default placeholder when there's no image
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemGray5))
                            .frame(height: 250)
                        
                        VStack {
                            Image(systemName: "photo.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundStyle(.gray)
                            
                            Text("No Image")
                                .font(.headline)
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding()
                }
                
                Text(cook.genre.uppercased())
                    .font(Themes.captionFont)
                    .fontWeight(.black)
                    .padding(7)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.65))
                    .clipShape(.capsule)
                    .offset(x: -25, y: -25)
            }
            
            Text("Added on \(cook.dateAdded?.formatted(date: .long, time: .shortened) ?? "[Unknown]")")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.bottom, 5)
            
            Text(cook.review)
                .padding(.horizontal, 18)
                .padding(.vertical, 12)
                .font(Themes.bodyFont)
            
            RatingView(rating: .constant(cook.rating))
                .font(.largeTitle)
                .padding(.bottom, 30)
            
            Button("Comments") {
                showingCommentSheet = true
            }
            .buttonStyle(Buttons())
            
        }
        .navigationTitle(cook.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete cook?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteCook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete this cook", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
        .sheet(isPresented: $showingCommentSheet) {
            CommentView(cook: cook)
        }
        .tint(.black)
    }
    
    func deleteCook() {
        modelContext.delete(cook)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Cook.self, configurations: config)
        let example = Cook(title: "Test Cook", genre: "Italian 🍝", review: "This was a great one; I really enjoyed it.", rating: 5, imageData: nil, dateAdded: Date())
        
        return DetailView(cook: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
