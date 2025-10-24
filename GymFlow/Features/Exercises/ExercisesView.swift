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
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var toastType: ToastType = .error
    
    @Binding var selectedExercise: Exercise?
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel: ExercisesViewModel
    
    init(viewModel: ExercisesViewModel, selectedExercise: Binding<Exercise?>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _selectedExercise = selectedExercise
    }
    
    var body: some View {
        ZStack {
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
                .listStyle(.plain)
                .task {
                    await fetchExercises()
                }
            }
            .navigationTitle("Упражение")
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always)
            )
            .overlay(alignment: .top) {
                if showToast {
                    ToastView(message: toastMessage, type: toastType) {
                        withAnimation(.easeInOut) { showToast = false }
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeInOut) { showToast = false }
                        }
                    }
                }
            }
            .animation(.easeInOut, value: showToast)

            if viewModel.isLoading {
                Color.black.opacity(0.25)
                    .ignoresSafeArea()
                LoaderView()
            }
        }
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
            toastMessage = "Произошла ошибка сети"
            toastType = .error
            withAnimation { showToast = true }
        }
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
