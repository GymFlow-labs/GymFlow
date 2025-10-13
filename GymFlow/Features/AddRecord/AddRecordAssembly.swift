//
//  AddRecordAssembly.swift
//  GymFlow
//
//  Created by Artem Kriukov on 12.10.2025.
//

import Foundation

final class AddRecordAssembly {
    private let servicesAssembly: ServicesAssembly
    private let exercisesAssembly: ExercisesAssembly
    
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        self.exercisesAssembly = ExercisesAssembly(serviceAssembly: servicesAssembly)
    }
    
    func build() -> AddRecordView {
        let workoutService = servicesAssembly.workoutServiceImpl
        
        let viewModel = AddRecordViewModel(
            workoutRecordRepository: workoutService
        )
        
        let view = AddRecordView(viewModel: viewModel, exercisesAssembly: exercisesAssembly)
        return view
    }
}
