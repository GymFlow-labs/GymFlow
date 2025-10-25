//
//  ExercisesAssembly.swift
//  GymFlow
//
//  Created by Artem Kriukov on 12.10.2025.
//

import SwiftUI

struct ExercisesAssembly {
    private let serviceAssembly: ServicesAssembly

    init(serviceAssembly: ServicesAssembly) {
        self.serviceAssembly = serviceAssembly
    }

    @MainActor
    func build(onSelectedExercise: ((Exercise) -> Void)? = nil) -> ExercisesView {
        let client = serviceAssembly.exercisesNetworkClientImpl
        let viewModel = ExercisesViewModel(exercisesNetworkClient: client)
        return ExercisesView(viewModel: viewModel)
    }
}
