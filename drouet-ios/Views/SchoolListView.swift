//
//  SchoolListView.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 20/11/2023.
//

import SwiftUI

struct SchoolListView: View {
    @ObservedObject var viewModel = SchoolListViewModel()
    @State private var addSchool = false
    @State private var editingSchool: School?
    let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.schools) { school in
                    VStack(alignment: .leading) {
                        AsyncImage(url: school.imageUrl) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                        
                        Text(school.name).font(.headline)
                        Text(school.category).font(.subheadline)
                        Text(school.description).font(.body)
                        Text("Fondée le : \(dateFormatter.string(from: school.foundationDate))")
                        Text("Nombre d'étudiants : \(school.studentCount)")
                    }
                    .onTapGesture {
                        editingSchool = school
                    }
                }
                .onDelete(perform: viewModel.deleteSchool)
            }
            .navigationBarTitle("Écoles")
            .navigationBarItems(trailing: Button(action: {
                addSchool = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $addSchool) {
                AddSchoolView(viewModel: viewModel)
            }
            .sheet(item: $editingSchool) { school in
                EditSchoolView(school: school, viewModel: viewModel)
            }
        }
    }
}

struct SchoolListView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListView()
    }
}
