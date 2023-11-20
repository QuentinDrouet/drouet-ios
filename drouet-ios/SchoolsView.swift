//
//  SchoolsView.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 20/11/2023.
//

import SwiftUI

struct SchoolsView: View {
    let schoolCategories: [SchoolCategory] = loadSchoolData()

    var body: some View {
        List(schoolCategories) { category in
            Section(header: Text(category.category)) {
                ForEach(category.schools, id: \.self) { school in
                    Text(school)
                }
            }
        }
        .navigationTitle("Écoles")
    }

    func loadSchoolData() -> [SchoolCategory] {
        guard let url = Bundle.main.url(forResource: "schools", withExtension: "json") else {
            fatalError("Failed to locate schools.json in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load schools.json from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loadedSchoolData = try? decoder.decode([SchoolCategory].self, from: data) else {
            fatalError("Failed to decode schools.json from bundle.")
        }

        return loadedSchoolData
    }
}

struct SchoolsView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolsView()
    }
}

