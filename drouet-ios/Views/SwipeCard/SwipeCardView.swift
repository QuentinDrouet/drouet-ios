//
//  SwipeCardView.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 20/11/2023.
//

import SwiftUI
import CardStack

struct SwipeCardView: View {
    @ObservedObject var viewModel : CardViewModel
    @State var reloadToken = UUID()
    
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
                .id(reloadToken)
                .onChange(of: viewModel.shouldRefreshCards) { _ in
                    if viewModel.shouldRefreshCards {
                        reloadToken = UUID()
                        viewModel.shouldRefreshCards = false
                    }
                }
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
}

