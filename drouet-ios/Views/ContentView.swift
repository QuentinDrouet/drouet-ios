//
//  ContentView.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 20/11/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var cardViewModel = CardViewModel()
    @StateObject var schoolViewModel = SchoolListViewModel()
    
    var body: some View {
        TabView {
            SwipeCardView(viewModel: cardViewModel)
                .tabItem {
                    Image(systemName: "hand.thumbsup.fill")
                }
            SchoolListView(viewModel: schoolViewModel)
                .tabItem {
                    Image(systemName: "graduationcap.fill")
                }
            RankingView(schoolViewModel: schoolViewModel, cardViewModel: cardViewModel)
                .tabItem {
                    Image(systemName: "trophy.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
