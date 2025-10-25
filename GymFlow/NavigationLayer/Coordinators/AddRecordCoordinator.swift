//
//  AddRecordCoordinator.swift
//  GymFlow
//
//  Created by Artem Kriukov on 19.10.2025.
//

import SwiftUI

final class AddRecordCoordinator: Coordinator {
    private var selectedExercise: Exercise?

    var navigationController: UINavigationController
    var completionHandler: CoordinatorHandler?

    let servicesAssembly: ServicesAssembly
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController, servicesAssembly: ServicesAssembly) {
        self.navigationController = navigationController
        self.servicesAssembly = servicesAssembly
    }

    func start() {
        showAddSelectionVC()
    }
    
    private func showAddSelectionVC() {
        let vc = AddSelectionViewController()
        vc.onAddRecord = { @MainActor [weak self] in
            self?.showExerciseForRecord()
        }
        navigationController.setViewControllers([vc], animated: false)
    }
    
    private func showAddRecord() {
        let addRecordAssembly = AddResultAssembly(servicesAssembly: servicesAssembly)
        var rootView = addRecordAssembly.build(
            typeView: .oneRepMax,
            selectedExercise: selectedExercise
        )
        
        rootView.onSelectExercise = { @MainActor [weak self] in
            self?.showExerciseForRecord()
        }
        
        rootView.onSave = { @MainActor [weak self] in
            self?.showAddSelectionVC()
        }
        
        let hosting = UIHostingController(rootView: rootView)
        navigationController.setViewControllers([hosting], animated: false)
    }
    
    @MainActor
    private func showExerciseForRecord() {
        let exercisesAssembly = ExercisesAssembly(serviceAssembly: servicesAssembly)
        var exercisesView = exercisesAssembly.build { [weak self] exercise in
            self?.showAddRecord()
        }
        
        exercisesView.onSelectedExercise = { [weak self] exercise in
            self?.selectedExercise = exercise
            self?.showAddRecord()
        }
        
        let hosting = UIHostingController(rootView: exercisesView)
        navigationController.pushViewController(hosting, animated: true)
    }
}
