//
//  AddRecordAssembly.swift
//  GymFlow
//
//  Created by Artem Kriukov on 12.10.2025.
//

import SwiftUI

final class AddResultAssembly {
    private let servicesAssembly: ServicesAssembly
    
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
    
    func build(
        typeView: AddResultViewType,
        onSelectExercise: ((Binding<Exercise?>) -> Void)? = nil
    ) -> AddResultView {
        let workoutService = servicesAssembly.workoutRecordServiceImpl
        
        let viewModel = AddResultViewModel(
            workoutRecordRepository: workoutService
        )
        
        let view = AddResultView(
            viewModel: viewModel,
            type: typeView,
            onSelectExercise: onSelectExercise
        )
        return view
    }
}
