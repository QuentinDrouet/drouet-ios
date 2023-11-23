//
//  SchoolRowView.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 23/11/2023.
//

import SwiftUI

struct SchoolRowView: View {
    let school: School

    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: school.imageUrl)) { image in
                image.resizable()
            } placeholder: {
                Circle().fill(Color.gray)
            }
            .frame(width: 70, height: 70)
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(school.name).font(.headline)
                Text(truncatedDescription(school.description)).font(.subheadline)
            }
        }
    }
    
    private func truncatedDescription(_ description: String) -> String {
        if description.count > 40 {
            let index = description.index(description.startIndex, offsetBy: 40)
            return String(description[..<index]) + "..."
        }
        return description
    }
}

