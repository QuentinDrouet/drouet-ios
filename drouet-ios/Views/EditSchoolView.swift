//
//  EditSchoolView.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 20/11/2023.
//

import SwiftUI

struct EditSchoolView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: SchoolListViewModel
    @State private var school: School

    init(school: School, viewModel: SchoolListViewModel) {
        _school = State(initialValue: school)
        _viewModel = ObservedObject(initialValue: viewModel)
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
                Button("Enregistrer les Modifications") {
                    viewModel.updateSchool(school)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationBarTitle("Modifier \(school.name)")
            .navigationBarItems(trailing: Button("Fermer") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

