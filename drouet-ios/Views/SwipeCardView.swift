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
            CardStack(
                direction: LeftRight.direction,
                data: viewModel.cards,
                onSwipe: { card, direction in
                    print("Swiped \(card) to \(direction)")
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
            .navigationTitle("Cards")
        }
    }
}

