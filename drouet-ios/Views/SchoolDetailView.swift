//
//  SchoolDetailView.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 20/11/2023.
//

import SwiftUI

struct SchoolDetailView: View {
    enum Mode {
        case add, edit
    }

    var mode: Mode
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: SchoolListViewModel
    @State private var school: School

    init(mode: Mode, viewModel: SchoolListViewModel, school: School? = nil) {
        self.mode = mode
        self._viewModel = ObservedObject(initialValue: viewModel)
        self._school = State(initialValue: school ?? School.empty)
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Nom", text: $school.name)
                TextField("Catégorie", text: $school.category)
                TextField("Description", text: $school.description)
                TextField("URL de l'Image", text: Binding(
                    get: { self.school.imageUrl.absoluteString },
                    set: { self.school.imageUrl = URL(string: $0) ?? self.school.imageUrl }
                ))
                DatePicker("Date de Fondation", selection: $school.foundationDate, displayedComponents: .date)
                TextField("Nombre d'Étudiants", text: Binding(
                    get: { String(self.school.studentCount) },
                    set: { self.school.studentCount = Int($0) ?? self.school.studentCount }
                ))
                Button(mode == .add ? "Ajouter une école" : "Enregistrer les Modifications") {
                    if mode == .add {
                        viewModel.addSchool(school)
                    } else {
                        viewModel.updateSchool(school)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationBarTitle(mode == .add ? "Ajouter une École" : "Modifier \(school.name)")
            .navigationBarItems(trailing: Button("Fermer") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

extension School {
    static var empty: School {
        return School(id: UUID().uuidString, name: "", category: "", description: "", imageUrl: URL(string: "https://example.com")!, foundationDate: Date(), studentCount: 0)
    }
}
