//
//  DetailView.swift
//  Bookworm
//
//  Created by DEEPAK BEHERA on 22/06/25.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    let book: Book
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingAlert = false
    var body: some View {
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    Image(book.genre)
                        .resizable()
                        .scaledToFit()
                    
                    Text(book.genre)
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundStyle(.white)
                        .background(.black.opacity(0.75))
                        .clipShape(.capsule)
                        .offset(x: -5, y: -5)
                }
                VStack {
                    Text(book.author)
                        .font(.title)
                        .foregroundStyle(.secondary)
                    HStack {
                        Text("Created on : ")
                        Text(book.date, format: .dateTime)
                    }
                    .font(.footnote)
                }
                

                Text(book.review)
                    .multilineTextAlignment(.center)
                    .padding()
                
                RatingView(rating: .constant(book.rating))
                    .font(.largeTitle)
            }
            .navigationTitle(book.title)
            .navigationBarTitleDisplayMode(.inline)
            .scrollBounceBehavior(.basedOnSize)
            .toolbar {
                Button("Delete Book", systemImage: "trash") {
                    showingAlert = true
                }
            }
            .alert("Delete Book", isPresented: $showingAlert) {
                Button("Delete", role: .destructive, action: deleteBook)
                Button("Cancel", role: .cancel, action: {})
            } message: {
                Text("Are you sure")
            }
    }
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This was a great book; I really enjoyed it.", rating: 4)
        return DetailView(book: example)
            .modelContainer(container)
        
    }
    catch {
        return Text("Filed to create preview: \(error.localizedDescription)")
    }
}
