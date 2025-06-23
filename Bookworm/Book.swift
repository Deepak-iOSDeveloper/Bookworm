//
//  Student.swift
//  Bookworm
//
//  Created by DEEPAK BEHERA on 20/06/25.
//
import SwiftUI
import SwiftData

@Model
class Student: Identifiable {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
