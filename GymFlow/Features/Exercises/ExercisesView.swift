//
//  ExercisesView.swift
//  GymFlow
//
//  Created by Artem Kriukov on 05.10.2025.
//
#warning("Добавить состояние загрузки(человечек подтягивается), вынести логику во VM")
import SwiftUI

struct ExercisesView: View {
    @State private var searchText = ""
    @State private var exerciseIsSelected = false
    
    @Binding var selectedExercise: Exercise?
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel: ExercisesViewModel
    
    init(viewModel: ExercisesViewModel, selectedExercise: Binding<Exercise?>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _selectedExercise = selectedExercise
    }
    
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
            .task {
                await fetchExercises()
            }
            .alert("Ошибка", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("Повторить") {
                    viewModel.errorMessage = nil
                    Task {
                        await fetchExercises()
                    }
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
        .navigationTitle("Exercises")
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        )
    }
    
    var searchResult: [Exercise] {
        let exercises = viewModel.exercises
        
        if searchText.isEmpty {
            return exercises
        } else {
            return exercises.filter { exercise in
                exercise.name.localizedCaseInsensitiveContains(searchText) ||
                exercise.nameRu.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    private func fetchExercises() async {
        do {
            try await viewModel.fetchExercises()
        } catch {
            viewModel.errorMessage = "Не удалось загрузить упражнение"
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
    let exercise: Exercise
    @Binding var selectedExercise: Exercise?
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
