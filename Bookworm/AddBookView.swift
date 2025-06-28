//
//  AddBookView.swift
//  Bookworm
//
//  Created by DEEPAK BEHERA on 21/06/25.
//

import Foundation
import SwiftData
import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var genre: String = "Fantasy"
    @State private var rating: Int = 3
    @State private var review: String = ""
    @State private var alertTitle = ""
    @State private var showingAlert = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            Form {
                Section("Book name") {
                    TextField("Enter book name", text: $title)
                }
                Section("Author name") {
                    TextField("Enter author name", text: $author)
                }
                Section("Genre selection") {
                    Picker("Select genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section("Write a review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                Section {
                    Button("Save") {
                        //insert to book model
                        if title.isEmpty {
                            alertTitle = "Please enter book title"
                            showingAlert = true
                        } else if author.isEmpty {
                            alertTitle = "Please enter the author name"
                            showingAlert = true
                        } else if review.isEmpty {
                            alertTitle = "Please write some review"
                            showingAlert = true
                        } else {
                            let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                            modelContext.insert(newBook)
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle("Add Book")
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {}
            }
        }
    }
}

#Preview {
    AddBookView()
}
