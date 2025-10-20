//
//  AddRecordAssembly.swift
//  GymFlow
//
//  Created by Artem Kriukov on 12.10.2025.
//

import SwiftUI

final class AddRecordAssembly {
    private let servicesAssembly: ServicesAssembly
    
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
    
    func build(onSelectExercise: ((Binding<Exercise?>) -> Void)? = nil) -> AddRecordView {
        let workoutService = servicesAssembly.workoutRecordServiceImpl
        
        let viewModel = AddRecordViewModel(
            workoutRecordRepository: workoutService
        )
        
        let view = AddRecordView(
            viewModel: viewModel,
            onSelectExercise: onSelectExercise
        )
        return view
    }
}
