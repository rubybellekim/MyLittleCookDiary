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
    @Query(sort: [SortDescriptor(\Cook.genre), SortDescriptor(\Cook.title)]) var cooks: [Cook]

    @State private var showingAddScreen = false
    @State private var selectedGenre: String? = nil

    var fontColors: [Color] = [.pink, .yellow, .green, .blue, .purple]

    var body: some View {
        NavigationStack {
            List {
                let genres = Set(cooks.map { $0.genre }).sorted()
                let filteredGenres = selectedGenre == nil ? genres : [selectedGenre!]

                ForEach(filteredGenres, id: \.self) { genre in
                    let genreCooks = cooks.filter { $0.genre == genre }
                    let colorIndex = genres.firstIndex(of: genre) ?? 0
                    let genreColor = fontColors[colorIndex % fontColors.count]

                    Section(header: Text(genre)
                        .font(Themes.titleFont)
                        .foregroundStyle(genreColor))
                    {
                        ForEach(genreCooks) { cook in
                            CookView(cook: cook) // Use `CookView` here
                        }
                        .onDelete { offsets in deleteCooks(from: genreCooks, at: offsets) }
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
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button("All") { selectedGenre = nil }
                        Divider()
                        ForEach(Set(cooks.map { $0.genre }).sorted(), id: \.self) { genre in
                            Button(genre) { selectedGenre = genre }
                        }
                    } label: {
                        Label("Filter by Genre", systemImage: "line.horizontal.3.decrease.circle")
                    }
                }
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
