//
//  AddSchoolView.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 20/11/2023.
//

import SwiftUI

struct AddSchoolView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: SchoolListViewModel
    @State private var name = ""
    @State private var category = ""
    @State private var description = ""
    @State private var imageUrl = ""
    @State private var foundationDate = Date()
    @State private var studentCountString = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nom", text: $name)
                TextField("Catégorie", text: $category)
                TextField("Description", text: $description)
                TextField("URL de l'Image", text: $imageUrl)
                DatePicker("Date de Fondation", selection: $foundationDate, displayedComponents: .date)
                TextField("Nombre d'Étudiants", text: $studentCountString)
                    .keyboardType(.numberPad)
                
                Button("Ajouter une école") {
                    addSchool()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationBarTitle("Ajouter une École")
            .navigationBarItems(trailing: Button("Fermer") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func addSchool() {
        let newSchool = School(
            id: UUID().uuidString,
            name: name,
            category: category,
            description: description,
            imageUrl: imageUrl,
            foundationDate: foundationDate,
            studentCount: Int(studentCountString) ?? 0
        )
        viewModel.addSchool(newSchool)
    }
}
