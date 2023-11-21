//
//  Card.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 20/11/2023.
//

import Foundation

struct Card: Identifiable, Codable {
    var id: String
    var text: String
    var category: String
}
