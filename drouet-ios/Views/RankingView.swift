//
//  RankingView.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 20/11/2023.
//

import SwiftUI

struct RankingView: View {
    @ObservedObject var schoolViewModel: SchoolListViewModel
    @ObservedObject var cardViewModel: CardViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(schoolViewModel.schools) { school in
                    Text(school.name)
                }
            }
            .onAppear {
                schoolViewModel.rankSchools()
            }
            .navigationBarItems(trailing: Button("Réinitialiser") {
                cardViewModel.resetData()
                schoolViewModel.loadSchools()
            })
            .navigationTitle("Classement")
        }
    }
}
