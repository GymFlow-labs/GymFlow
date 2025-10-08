//
//  ExercisesView.swift
//  GymFlow
//
//  Created by Artem Kriukov on 05.10.2025.
//

import SwiftUI

struct ExercisesView: View {
    @State private var searchText = ""
    @State private var exerciseIsSelected = false
    
    let exercises = ["Жим лежа", "Приседания", "Становая тяга", "Подтягивания"]
    
    var body: some View {
        VStack {
            List {
                ForEach(searchResult, id: \.self) { exercise in
                    Text(exercise)
                }
            }
        }
        .navigationTitle("Exercises")
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        )
    }
    
    var searchResult: [String] {
        if searchText.isEmpty {
            return exercises
        } else {
            return exercises.filter { $0.contains(searchText) }
        }
    }
}

#Preview {
    ExercisesView()
}

struct SearchView: View {
    @Binding var searchText: String
    
    var body: some View {
        Text(searchText)
    }
}
