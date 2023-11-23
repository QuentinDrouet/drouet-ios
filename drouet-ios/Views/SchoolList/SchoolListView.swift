//
//  SchoolListView.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 20/11/2023.
//

import SwiftUI

struct SchoolListView: View {
    @ObservedObject var viewModel: SchoolListViewModel
    @State private var addSchool = false
    @State private var showingCVECInput = false
    let dateFormatter: DateFormatter
    
    init(viewModel: SchoolListViewModel) {
        self.viewModel = viewModel
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = .long
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    showingCVECInput = true
                }) {
                    HStack {
                        Image(systemName: "doc.text")
                            .foregroundColor(Color("CardBlue"))
                            .padding(8)
                            .background(Color.white)
                            .clipShape(Circle())
                        
                        Text("Vérifier le CVEC")
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.white)
                    }
                }
                .padding()
                .background(Color("CardBlue"))
                .cornerRadius(10)
                .padding()
                .sheet(isPresented: $showingCVECInput) {
                    CVECInputView()
                }
                
                List {
                    ForEach(viewModel.schoolsByCategory.keys.sorted(), id: \.self) { category in
                        Section(header: Text(category)) {
                            ForEach(viewModel.schoolsByCategory[category] ?? [], id: \.id) { school in
                                NavigationLink(destination: SchoolDetailView(school: school, viewModel: viewModel)) {
                                    SchoolRowView(school: school)
                                }
                            }
                            .onDelete { indexSet in
                                indexSet.forEach { index in
                                    viewModel.deleteSchool(category: category, at: index)
                                }
                            }
                        }.listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .navigationBarTitle("Écoles")
            .navigationBarItems(trailing: Button(action: {
                addSchool = true
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color("Red"))
                    .clipShape(Circle())
            })
            .sheet(isPresented: $addSchool) {
                AddOrEditSchoolView(school: nil, viewModel: viewModel)
            }
        }
    }
}
