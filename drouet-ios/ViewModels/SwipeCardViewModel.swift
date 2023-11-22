//
//  SwipeCardViewModel.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 20/11/2023.
//

import Foundation

class CardViewModel: ObservableObject {
    @Published var cards: [Card] = []
    var responses: [String: Bool]
    var swipedCardIDs: Set<String> {
        didSet {
            UserDefaults.standard.set(Array(swipedCardIDs), forKey: "SwipedCardIDs")
        }
    }
    var currentTopCard: Card? {
        cards.first
    }
    
    init() {
        responses = UserDefaults.standard.object(forKey: "CardResponses") as? [String: Bool] ?? [:]
        let savedCardIDs = UserDefaults.standard.object(forKey: "SwipedCardIDs") as? [String] ?? []
        swipedCardIDs = Set(savedCardIDs)
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
            let allCards = try decoder.decode([Card].self, from: data)
            cards = allCards.filter { !swipedCardIDs.contains($0.id) }
        } catch {
            print("Erreur lors de la lecture ou du décodage du JSON : \(error)")
        }
    }
    
    func swipeCard(_ card: Card, direction: SwipeDirection) {
        switch direction {
        case .right:
            responses[card.criteria] = true
        case .left:
            responses[card.criteria] = false
        }
        saveResponsesToUserDefaults()
        swipedCardIDs.insert(card.id)
    }
    
    private func saveResponsesToUserDefaults() {
        UserDefaults.standard.set(responses, forKey: "CardResponses")
    }
}

enum SwipeDirection {
    case left, right
}
