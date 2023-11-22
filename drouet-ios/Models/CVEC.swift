//
//  Cvec.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 22/11/2023.
//

import Foundation

struct CVECResponse: Codable {
    var name: String
    var state: CVECState

    enum CodingKeys: String, CodingKey {
        case name = "nom"
        case state = "etat"
    }
}

struct CVECState: Codable {
    var label: String

    enum CodingKeys: String, CodingKey {
        case label = "libelle"
    }
}

struct CVECErrorResponse: Codable {
    var message: String
}
