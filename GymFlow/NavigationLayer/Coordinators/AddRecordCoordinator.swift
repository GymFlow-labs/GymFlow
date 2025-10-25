//
//  AddRecordCoordinator.swift
//  GymFlow
//
//  Created by Artem Kriukov on 19.10.2025.
//

import SwiftUI

final class AddRecordCoordinator: Coordinator {
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
        
        vc.onAddTest = { @MainActor [weak self] in
            self?.showCrossfitTests()
        }
        
        navigationController.setViewControllers([vc], animated: true)
    }
    
    private func showAddRecord(
        type: AddResultViewType,
        selectedExercise: Exercise? = nil,
        selectedTest: CrossfitTest? = nil
    ) {
        let addRecordAssembly = AddResultAssembly(servicesAssembly: servicesAssembly)
        var rootView = addRecordAssembly.build(
            typeView: type,
            selectedExercise: selectedExercise,
            selectedTest: selectedTest
        )
        
        rootView.onSelectExercise = { @MainActor [weak self] in
            self?.showExerciseForRecord()
        }
        
        rootView.onSelectTest = { @MainActor [weak self] in
            self?.showCrossfitTests()
        }
        
        rootView.onSave = { @MainActor [weak self] in
            self?.showAddSelectionVC()
        }
        
        let hosting = UIHostingController(rootView: rootView)
        navigationController.pushViewController(hosting, animated: true)
    }
    
    private func showCrossfitTests() {
        let vc = CrossfitTestsViewController()
        vc.onTestSelected = { [weak self] test in
            self?.showAddRecord(type: .test, selectedTest: test)
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    @MainActor
    private func showExerciseForRecord() {
        let exercisesAssembly = ExercisesAssembly(serviceAssembly: servicesAssembly)
        var exercisesView = exercisesAssembly.build { [weak self] exercise in
            self?.showAddRecord(
                type: .oneRepMax,
                selectedExercise: exercise
            )
        }
        
        exercisesView.onSelectedExercise = { [weak self] exercise in
            self?.showAddRecord(type: .oneRepMax, selectedExercise: exercise)
        }
        
        let hosting = UIHostingController(rootView: exercisesView)
        navigationController.pushViewController(hosting, animated: true)
    }
}
