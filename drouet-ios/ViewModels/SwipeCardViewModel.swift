//
//  SwipeCardViewModel.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 20/11/2023.
//

import Foundation

class CardViewModel: ObservableObject {
    @Published var cards: [Card] = []
    
    init() {
        loadCards()
    }
    
    func loadCards() {
        guard let url = Bundle.main.url(forResource: "cards", withExtension: "json") else {
            print("Erreur : fichier JSON introuvable.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            cards = try decoder.decode([Card].self, from: data)
        } catch {
            print("Erreur lors de la lecture ou du décodage du JSON : \(error)")
        }
    }
}

