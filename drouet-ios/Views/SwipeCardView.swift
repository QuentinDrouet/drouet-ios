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
    @State private var swipeDirection: SwipeDirection? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                CardStack(
                    direction: LeftRight.direction,
                    data: viewModel.cards,
                    onSwipe: { card, direction in
                        let swipeDirection: SwipeDirection = (direction == .left) ? .left : .right
                        viewModel.swipeCard(card, direction: swipeDirection)
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
                .aspectRatio(1, contentMode: .fit)                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle("Cards")
        }
    }
    
    func swipeCard(direction: SwipeDirection) {
        if let card = viewModel.currentTopCard {
            viewModel.swipeCard(card, direction: direction)
        }
    }
}

