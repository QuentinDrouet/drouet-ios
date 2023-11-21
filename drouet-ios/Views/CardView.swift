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
            Text(card.text)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
            
            Text(card.category)
                .padding(10)
                .font(.subheadline)
                .foregroundColor(Color("CardBlue"))
                .background(.white)
                .cornerRadius(90)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
        .background(Color("CardBlue"))
        .cornerRadius(20)
    }
}
