//
//  ContentView.swift
//  MyLittleCookDiary
//
//  Created by Ruby Kim on 2025-02-18.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Cook.dateAdded),
        SortDescriptor(\Cook.title)
    ]) var cooks: [Cook]
    

    @State private var showingAddScreen = false
    
    var fontColors = [Color.pink, Color.yellow, Color.green, Color.blue, Color.purple]

    var body: some View {
        NavigationStack {
                    List {
                        // Group cooks by genre
                        let groupedCooks = Dictionary(grouping: cooks, by: { $0.genre })

                        ForEach(groupedCooks.keys.sorted(), id: \.self) { genre in
                            if let genreCooks = groupedCooks[genre], !genreCooks.isEmpty {
                                
                                let colorIndex = groupedCooks.keys.sorted().firstIndex(of: genre) ?? 0
                                let genreColor = fontColors[colorIndex % fontColors.count]
                                
                                Section(header: Text("\(genre)").font(.headline).foregroundStyle(genreColor)) {
                                    ForEach(genreCooks) { cook in
                                        NavigationLink(value: cook) {
                                            HStack {
                                                EmojiRatingView(rating: cook.rating)
                                                    .font(.largeTitle)
                                                VStack(alignment: .leading) {
                                                    Text(cook.title)
                                                        .font(.headline)
                                                        .foregroundStyle(cook.rating == 1 ? .red : .primary)
                                                    
                                                }
                                            }
                                        }
                                    }
                                    .onDelete { offsets in deleteCooks(from: genreCooks, at: offsets) }
                                }
                            }
                        }
                    }
                    .navigationTitle("My Little Cook Diary")
                    .navigationBarTitleTextColor(.orange)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            EditButton()
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: { showingAddScreen.toggle() }) {
                                Label("Add Cook", systemImage: "plus")
                            }
                        }
//                        ToolbarItem(placement: .topBarTrailing) {
//                            Menu("Sort", systemImage: "arrow.up.arrow.down") {
//                                Text("Italian")
//                                    .tag([
//                                        SortDescriptor(\Cook.genre)
//                                    ])
//                            }
//                        }
                    }
                    .sheet(isPresented: $showingAddScreen) {
                        AddCookView()
                    }
                    .navigationDestination(for: Cook.self) { cook in
                        DetailView(cook: cook)
                    }
                    .preferredColorScheme(.light)
                }
                .tint(.black)
            }

    
    func deleteCooks(from genreCooks: [Cook], at offsets: IndexSet) {
        for index in offsets {
            let cook = genreCooks[index]
            modelContext.delete(cook)
        }
    }
}

#Preview {
    ContentView()
}
