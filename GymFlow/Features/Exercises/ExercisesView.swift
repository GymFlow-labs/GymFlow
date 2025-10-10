//
//  ExercisesView.swift
//  GymFlow
//
//  Created by Artem Kriukov on 05.10.2025.
//
#warning("Добавить состояние загрузки, вынести логику во VM")
import SwiftUI

struct ExercisesView: View {
    @State private var searchText = ""
    @State private var exerciseIsSelected = false
    
    @Binding var selectedExercise: DTOExercise?
    @Environment(\.dismiss) var dismiss
    
    @State private var exercises: [DTOExercise] = []
    let network = NetworkService.shared
    
    var body: some View {
        VStack {
            List {
                ForEach(searchResult, id: \.id) { exercise in
                    ExerciseButtonView(
                        exercise: exercise,
                        selectedExercise: $selectedExercise,
                        dismiss: dismiss
                    )
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

struct SearchView: View {
    @Binding var searchText: String
    
    var body: some View {
        Text(searchText)
    }
}

struct ExerciseButtonView: View {
    let exercise: DTOExercise
    @Binding var selectedExercise: DTOExercise?
    let dismiss: DismissAction
    
    var body: some View {
        Button(
            action: {
                selectedExercise = exercise
                dismiss()
            },
            label: {
                HStack {
                    Text(exercise.nameRu)
                        .foregroundColor(Color.primaryTextColor)
                    Spacer()
                    
                    if selectedExercise?.id == exercise.id {
                        Image(systemName: "checkmark")
                            .foregroundColor(.accentColor)
                    }
                }
                .contentShape(Rectangle())
            }
        )
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        ExercisesView(selectedExercise: .constant(nil))
    }
}
