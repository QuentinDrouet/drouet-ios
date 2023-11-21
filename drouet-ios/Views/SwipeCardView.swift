//
//  SwipeCardView.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 20/11/2023.
//

import SwiftUI
import CardStack

struct SwipeCardView: View {
    @ObservedObject var viewModel = CardViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                CardStack(
                    direction: LeftRight.direction,
                    data: viewModel.cards,
                    onSwipe: { card, direction in
                        let swipeDirection: SwipeDirection = (direction == .left) ? .left : .right
                        viewModel.swipeCard(card, direction: swipeDirection)
                        print("Swiped \(card.text) to \(direction)")
                    },
                    content: { card, direction, isOnTop in
                        CardView(card: card)
                            .padding()
                    }
                )
                .environment(\.cardStackConfiguration, CardStackConfiguration(
                    maxVisibleCards: 3,
                    cardOffset: 20
                ))
                
                Button("Voir les Réponses") {
                    printResponses()
                }
            }
            .navigationTitle("Cards")
        }
    }
    
    private func printResponses() {
        for (criteria, response) in viewModel.responses {
            print("\(criteria): \(response ? "like" : "dislike")")
        }
    }
}

