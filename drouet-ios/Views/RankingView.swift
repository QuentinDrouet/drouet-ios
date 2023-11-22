//
//  RankingView.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 20/11/2023.
//

import SwiftUI

struct RankingView: View {
    @ObservedObject var schoolViewModel = SchoolListViewModel()
    @State private var showingSettings = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(schoolViewModel.schools) { school in
                        Text(school.name)
                    }
                }
                .onAppear {
                    schoolViewModel.rankSchools()
                }
            }
            .navigationTitle("Classement")
        }
    }
}

