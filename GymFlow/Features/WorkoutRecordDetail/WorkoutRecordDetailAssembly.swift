//
//  WorkoutRecordDetailAssembly.swift
//  GymFlow
//
//  Created by Artem Kriukov on 14.10.2025.
//

import Foundation

struct WorkoutRecordDetailAssembly {
    private let serviceAssembly: ServicesAssembly
    
    init(serviceAssembly: ServicesAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func build(with exerciseModel: Exercise) -> WorkoutRecordDetailViewController {
        let viewModel = WorkoutRecordDetailViewModel(
            workoutRecordsRepositories: serviceAssembly.workoutRecordServiceImpl
        )
        
        let viewController = WorkoutRecordDetailViewController(
            exercise: exerciseModel,
            viewModel: viewModel
        )
        
        return viewController
    }
}
