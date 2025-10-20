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
        let addRecordAssembly = AddRecordAssembly(servicesAssembly: servicesAssembly)
        let rootView = addRecordAssembly.build { [weak self] selectedExercise in
            Task { @MainActor [weak self] in
                self?.showExercises(selectedExercise)
            }
        }
        
        let hosting = UIHostingController(rootView: rootView)
        navigationController.setViewControllers([hosting], animated: false)
    }
    
    @MainActor
    private func showExercises(_ selectedExercise: Binding<Exercise?>) {
        let exercisesAssembly = ExercisesAssembly(serviceAssembly: servicesAssembly)
        let exercisesView = exercisesAssembly.build(selectedExercise: selectedExercise)
        let hosting = UIHostingController(rootView: exercisesView)
        navigationController.pushViewController(hosting, animated: true)
    }
}
