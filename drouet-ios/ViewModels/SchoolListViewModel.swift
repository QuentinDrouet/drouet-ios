//
//  SchoolListViewModel.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 20/11/2023.
//

import Foundation

class SchoolListViewModel: ObservableObject {
    @Published var schools: [School] = []

    init() {
        loadSchools()
    }

    func loadSchools() {
        guard let url = Bundle.main.url(forResource: "schools", withExtension: "json") else {
            print("Erreur : fichier JSON introuvable.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            schools = try decoder.decode([School].self, from: data)
        } catch {
            print("Erreur lors de la lecture ou du décodage du JSON : \(error)")
        }
    }

    
    func addSchool(_ school: School) {
            schools.append(school)
        }
    
    func updateSchool(_ updatedSchool: School) {
            if let index = schools.firstIndex(where: { $0.id == updatedSchool.id }) {
                schools[index] = updatedSchool
            }
        }
}
