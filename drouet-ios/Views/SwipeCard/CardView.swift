//
//  CardView.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 21/11/2023.
//

import SwiftUI

struct CardView: View {
    var card: Card
    
    var body: some View {
        VStack {
            Spacer()

            Text(card.category)
                .padding(10)
                .font(.subheadline)
                .foregroundColor(Color(card.color))
                .background(.white)
                .cornerRadius(90)
                .frame(maxWidth: .infinity, alignment: .center)

            Text(card.text)
                .padding(.top, 30)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
        .background(Color(card.color))
        .cornerRadius(20)
    }
}
