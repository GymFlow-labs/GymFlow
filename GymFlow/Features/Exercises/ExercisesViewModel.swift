//
//  ExercisesViewModel.swift
//  GymFlow
//
//  Created by Artem Kriukov on 11.10.2025.
//

import Foundation

@MainActor
final class ExercisesViewModel: ObservableObject {
    private let exercisesNetworkClient: ExercisesAPIProtocol
    
    @Published private(set) var exercises: [Exercise] = []
    @Published var errorMessage: String?
    
    init(exercisesNetworkClient: ExercisesAPIProtocol) {
        self.exercisesNetworkClient = exercisesNetworkClient
    }
    
    func fetchExercises() async throws {
        do {
            let response = try await exercisesNetworkClient.fetchExercises()
            self.exercises = response.map { Exercise(from: $0) }
            self.errorMessage = nil
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
