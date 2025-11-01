//
//  ExercisesViewModel.swift
//  GymFlow
//
//  Created by Artem Kriukov on 11.10.2025.
//

import Foundation

@MainActor
protocol ExercisesViewModelProtocol: ObservableObject {
    var exercises: [Exercise] { get }
    func fetchExercises() async throws
}

@MainActor
final class ExercisesViewModel: ExercisesViewModelProtocol {
    private let exercisesNetworkClient: ExercisesAPIProtocol
    
    @Published private(set) var exercises: [Exercise] = exercisesDataSource
    @Published var isLoading = false
    
    init(exercisesNetworkClient: ExercisesAPIProtocol) {
        self.exercisesNetworkClient = exercisesNetworkClient
    }
    
    func fetchExercises() async throws {
        isLoading = true
        
        do {
            let response = try await exercisesNetworkClient.fetchExercises()
            self.exercises = response.map { Exercise(from: $0) }
        } catch {
            print("[ExercisesViewModel -> fetchExercises] Error: \(error)]")
        }
        
        isLoading = false
    }
}
