//
//  SchoolCategory.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 20/11/2023.
//

import Foundation

struct SchoolCategory: Codable, Identifiable {
    var id = UUID()
    var category: String
    var schools: [String]
}

