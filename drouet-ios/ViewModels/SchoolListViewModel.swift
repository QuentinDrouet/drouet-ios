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
    
    func deleteSchool(at offsets: IndexSet) {
        schools.remove(atOffsets: offsets)
    }
    
    func rankSchools() {
        let responses = UserDefaults.standard.object(forKey: "CardResponses") as? [String: Bool] ?? [:]
        let rankedSchools = schools.sorted { (school1, school2) -> Bool in
            let score1 = calculateScore(for: school1, basedOn: responses)
            let score2 = calculateScore(for: school2, basedOn: responses)
            return score1 > score2
        }
        
        self.schools = rankedSchools
    }
    
    private func calculateScore(for school: School, basedOn responses: [String: Bool]) -> Int {
        var score = 0
        for (criteria, userPreference) in responses {
            if let schoolPreference = school.attributes[criteria] {
                score += (schoolPreference == userPreference) ? 1 : 0
            }
        }
        return score
    }
}
