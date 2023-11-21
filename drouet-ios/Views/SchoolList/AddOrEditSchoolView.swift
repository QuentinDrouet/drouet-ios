//
//  AddOrEditSchoolView.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 21/11/2023.
//

import SwiftUI

struct AddOrEditSchoolView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: SchoolListViewModel
    @State private var school: School
    @State private var isNewSchool: Bool

    init(school: School?, viewModel: SchoolListViewModel) {
        _viewModel = ObservedObject(initialValue: viewModel)
        if let school = school {
            _school = State(initialValue: school)
            _isNewSchool = State(initialValue: false)
        } else {
            _school = State(initialValue: School(id: UUID().uuidString, name: "", category: "", description: "", imageUrl: "", foundationDate: Date(), studentCount: 0, attributes: ["":false]))
            _isNewSchool = State(initialValue: true)
        }
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Nom", text: $school.name)
                TextField("Catégorie", text: $school.category)
                TextField("Description", text: $school.description)
                TextField("URL de l'Image", text: $school.imageUrl)
                DatePicker("Date de Fondation", selection: $school.foundationDate, displayedComponents: .date)
                TextField("Nombre d'Étudiants", value: $school.studentCount, format: .number)

                Button(isNewSchool ? "Ajouter École" : "Enregistrer les Modifications") {
                    if isNewSchool {
                        viewModel.addSchool(school)
                    } else {
                        viewModel.updateSchool(school)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationBarTitle(isNewSchool ? "Ajouter une École" : "Modifier École")
            .navigationBarItems(trailing: Button("Fermer") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

