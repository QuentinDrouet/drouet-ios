//
//  SchoolDetailView.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 21/11/2023.
//

import SwiftUI

struct SchoolDetailView: View {
    let school: School
    @ObservedObject var viewModel: SchoolListViewModel
    @State private var editingSchool: Bool = false
    let dateFormatter: DateFormatter
    
    init(school: School, viewModel: SchoolListViewModel) {
        self.school = school
        self.viewModel = viewModel
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: school.imageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    Circle().fill(Color.gray)
                }
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                
                Text(school.name).font(.headline)
                Text(school.category).font(.subheadline)
                Text(school.description).font(.body)
                Text("Fondée le : \(dateFormatter.string(from: school.foundationDate))")
                Text("Nombre d'étudiants : \(school.studentCount)")
            }
        }
        .navigationBarTitle(school.name, displayMode: .inline)
        .navigationBarItems(trailing: Button("Modifier") {
            editingSchool = true
        })
        .sheet(isPresented: $editingSchool) {
            AddOrEditSchoolView(school: school, viewModel: viewModel)
        }
    }
}
