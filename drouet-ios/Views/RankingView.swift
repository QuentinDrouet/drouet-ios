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
            List(schoolViewModel.schools, id: \.id) { school in
                NavigationLink(destination: SchoolDetailView(school: school, viewModel: schoolViewModel)) {
                    SchoolRowView(school: school)
                        .listRowSeparator(.hidden)
                }.listRowSeparator(.hidden)
            }
            .onAppear {
                schoolViewModel.rankSchools()
            }
            .listStyle(.plain)
            .navigationTitle("Classement")
            .navigationBarItems(trailing: Button(action: {
                cardViewModel.resetData()
                schoolViewModel.loadSchools()
            }) {
                Text("Réinitialiser")
                    .font(.subheadline)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color("Red"))
                    .cornerRadius(20)
                    .foregroundColor(.white)
            })
        }
    }
}
