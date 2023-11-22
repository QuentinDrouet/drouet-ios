//
//  ContentView.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 20/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            SwipeCardView()
                .tabItem {
                    Image(systemName: "hand.thumbsup.fill")
                }
            SchoolListView()
                .tabItem {
                    Image(systemName: "graduationcap.fill")
                }
            RankingView()
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
