//
//  CommentView.swift
//  MyLittleCookDiary
//
//  Created by Ruby Kim on 2025-02-24.
//

import SwiftUI
import SwiftData

struct CommentView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query(sort: [SortDescriptor(\Comment.date, order: .reverse)])
    
    var comments: [Comment]
    
    @Bindable var cook: Cook
    
    @State private var newCommentText = ""
    @State private var showingDeleteAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(comments.filter { $0.cook?.id == cook.id }) { comment in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(comment.text)
                                    .padding(.vertical, 4)
                                Text(comment.date.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            Spacer()
                            Button(action: { deleteComment(comment) }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
                .font(Themes.bodyFont)
                
                HStack {
                    TextField("Add a comment...", text: $newCommentText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(Themes.bodyFont)
                    
                    Button(action: addComment) {
                        Image(systemName: "paperplane.fill")
                            .foregroundStyle(newCommentText.isEmpty ? .gray : .blue)
                    }
                    .disabled(newCommentText.isEmpty)
                }
                .padding()
            }
            .navigationTitle("Comments")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") { dismiss() } // Dismiss the sheet
                }
            }
        }
    }
        
        func addComment() {
            let newComment = Comment(text: newCommentText, cook: cook)
            modelContext.insert(newComment) // Save comment in SwiftData
            newCommentText = "" // Reset text field
        }
        
        func deleteComment(_ comment: Comment) {
            modelContext.delete(comment)
        }
}

