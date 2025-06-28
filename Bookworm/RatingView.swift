//
//  RatingView.swift
//  Bookworm
//
//  Created by DEEPAK BEHERA on 21/06/25.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var maxRating = 5
    var label = ""
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color(.gray)
    var onColor = Color(.yellow)
    var body: some View {
        NavigationStack {
            HStack {
                if !label.isEmpty {
                    Text(label)
                }
                ForEach(1..<maxRating+1, id: \.self) { number in
                    Button {
                        rating = number
                    } label: {
                        image(for: number)
                            .foregroundStyle(number > rating ? offColor : onColor)
                    }
                }
            }
            .buttonStyle(.plain)
        }
    }
    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(3))
}
