//
//  AddCookView.swift
//  MyLittleCookDiary
//
//  Created by Ruby Kim on 2025-02-19.
//

import SwiftUI
import PhotosUI
import SwiftData

struct AddCookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var rating = 0
    @State private var genre = "Italian 🍝"
    @State private var review = ""
    @State private var imageData: Data?
    
    @State var characterLimit = 500
    @State var typedCharacters = 0
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var addedImage: Image?
    
    @State private var deleteAction = false

    let genres = ["Italian 🍝", "American 🍔", "Asian 🍣", "Mediterranean 🫒", "Dessert 🍰", "Drink 🍹", "Others 🍽️"]
    
    var disableForm: Bool {
        title == "" || rating == 0
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    // Photo Picker
                    
                    addedImage?
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 300)
                    
                    if deleteAction {
                        Button {
                            addedImage = nil
                            imageData = nil
                            deleteAction = false
                        } label: {
                            Label("Delete", systemImage: "trash")
                                .foregroundStyle(.red)
                        }
                    }
                    
                                    PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                                        Label("Select Recipe Image", systemImage: "photo")
                                    }
                    

                    
                                    .onChange(of: selectedItem) {
                                        Task {
                                            if let loaded = try? await selectedItem?.loadTransferable(type: Image.self) {
                                                addedImage = loaded
                                                deleteAction = true
                                                loadImage()
                                            } else {
                                                print("Failed")
                                            }
                                        }
                                        }
                    }
                
               
                
                
                Section {
                    TextField("Name of menu", text: $title)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Leave a note") {
                    TextEditor(text: $review)
                    
                    Text("\(typedCharacters) / \(characterLimit)")
                    .foregroundColor(Color.gray)
                    .font(.caption)
                    
                    RatingView(rating: $rating)
                    

                    
//                    Picker("Rating", selection: $rating) {
//                        ForEach(0..<6) {
//                            Text(String($0))
//                        }
//                    }
                }
                .onChange(of: review) { oldValue, newValue in
                    typedCharacters = newValue.count
                    review = String(newValue.prefix(characterLimit))
                }
                
                
                Section {
                    Button("Save") {
                        let newCook = Cook(title: title, genre: genre, review: review, rating: rating, imageData: imageData)
                        modelContext.insert(newCook)
                        dismiss()
                    }
                }
                .disabled(disableForm)
            }
            .navigationTitle("Add Cook")
        }
        .tint(.black)
    }
    
    func loadImage() {
            Task {
                if let selectedItem,
                   let data = try? await selectedItem.loadTransferable(type: Data.self) {
                    imageData = data
                }
            }
        }
}

#Preview {
    AddCookView()
}
