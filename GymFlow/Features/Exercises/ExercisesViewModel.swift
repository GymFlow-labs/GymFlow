//
//  ExercisesViewModel.swift
//  GymFlow
//
//  Created by Artem Kriukov on 11.10.2025.
//

import Foundation

@MainActor
final class ExercisesViewModel: ObservableObject {
    private let networkService: NetworkClient
    
    @Published private(set) var exercises: [Exercise] = []
    @Published var errorMessage: String?
    
    init(networkService: NetworkClient) {
        self.networkService = networkService
    }
    
    func fetchExercises() async throws {
        do {
            let response = try await networkService.fetchExercises()
            self.exercises = response.map { Exercise(from: $0) }
        } catch {
            print("[ExercisesViewModel]: Error fetching exercises: \(error.localizedDescription)")
        }
    }
}
