//
//  WorkoutRecordDetailViewModel.swift
//  GymFlow
//
//  Created by Artem Kriukov on 14.10.2025.
//

import Foundation

protocol WorkoutRecordDetailViewModelProtocol {
    var workoutRecord: [WorkoutRecord] { get }
    func fetchWorkoutRecords(for exerciseId: String, completion: @escaping () -> Void)
}

final class WorkoutRecordDetailViewModel: WorkoutRecordDetailViewModelProtocol {
    
    private var workoutRecordsRepositories: WorkoutRecordRepositoryProtocol
    private(set) var workoutRecord: [WorkoutRecord] = []
    
    init(workoutRecordsRepositories: WorkoutRecordRepositoryProtocol) {
        self.workoutRecordsRepositories = workoutRecordsRepositories
    }
    
    func fetchWorkoutRecords(for exerciseId: String, completion: @escaping () -> Void) {
        let records = workoutRecordsRepositories.fetchRecords(forExerciseID: exerciseId)
        self.workoutRecord = records
        completion()
    }
}
