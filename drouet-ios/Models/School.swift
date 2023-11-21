//
//  School.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 20/11/2023.
//

import Foundation

struct School: Identifiable, Codable {
    var id: String
    var name: String
    var category: String
    var description: String
    var imageUrl: String
    var foundationDate: Date
    var studentCount: Int
    var attributes: [String: Bool]
}
