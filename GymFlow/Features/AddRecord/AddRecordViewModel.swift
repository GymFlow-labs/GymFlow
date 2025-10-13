//
//  AddRecordViewModel.swift
//  GymFlow
//
//  Created by Artem Kriukov on 12.10.2025.
//

import Foundation

struct AddRecordViewModel {
    private let workoutRecordRepository: WorkoutRecordRepositoryProtocol
    
    init(workoutRecordRepository: WorkoutRecordRepositoryProtocol) {
        self.workoutRecordRepository = workoutRecordRepository
    }
    
    func addRecord(for exercise: Exercise, date: Date, weight: Double) async throws {
        try await workoutRecordRepository.addRecord(for: exercise, date: date, weight: weight)
    }
}
