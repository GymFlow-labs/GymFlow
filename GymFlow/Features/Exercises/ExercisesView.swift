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
    
    @State private var exercises: [DTOExercise] = []
    let network = NetworkService.shared
    
    var body: some View {
        VStack {
            List {
                ForEach(searchResult, id: \.id) { exercise in
                    Text(exercise.nameRu)
                }
            }
        }
        .navigationTitle("Exercises")
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        )
        .onAppear {
            Task {
                do {
                    exercises = try await network.fetchExercises()
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    var searchResult: [DTOExercise] {
        if searchText.isEmpty {
            return exercises
        } else {
            return exercises.filter { exercise in
                exercise.name.localizedCaseInsensitiveContains(searchText) ||
                exercise.nameRu.localizedCaseInsensitiveContains(searchText)
            }
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
