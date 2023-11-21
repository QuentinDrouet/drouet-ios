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
    let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.schools) { school in
                    NavigationLink(destination: SchoolDetailView(school: school, viewModel: viewModel)) {
                        HStack(spacing: 16) {
                            AsyncImage(url: URL(string: school.imageUrl)) { image in
                                image.resizable()
                            } placeholder: {
                                Circle().fill(Color.gray)
                            }
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(school.name).font(.headline)
                                Text(school.category).font(.subheadline).foregroundColor(.gray)
                                Text(truncatedDescription(school.description)).font(.subheadline)
                            }
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteSchool)
            }
            .navigationTitle("Écoles")
            .navigationBarItems(trailing: Button(action: {
                addSchool = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $addSchool) {
                AddOrEditSchoolView(school: nil, viewModel: viewModel)
            }
        }
    }
    
    private func truncatedDescription(_ description: String) -> String {
        if description.count > 40 {
            let index = description.index(description.startIndex, offsetBy: 40)
            return String(description[..<index]) + "..."
        }
        return description
    }
}

struct SchoolListView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListView()
    }
}
