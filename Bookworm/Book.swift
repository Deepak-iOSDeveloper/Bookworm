//
//  Student.swift
//  Bookworm
//
//  Created by DEEPAK BEHERA on 20/06/25.
//
import SwiftUI
import SwiftData

@Model
class Book: Hashable {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var date: Date

    init(title: String, author: String, genre: String, review: String, rating: Int, date: Date = Date()) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.date = date
    }
}

