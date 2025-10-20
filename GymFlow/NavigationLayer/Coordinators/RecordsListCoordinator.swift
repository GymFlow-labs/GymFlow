//
//  RecordsListCoordinator.swift
//  GymFlow
//
//  Created by Artem Kriukov on 19.10.2025.
//

import UIKit

final class RecordsListCoordinator: Coordinator {
    var navigationController: UINavigationController

    var completionHandler: CoordinatorHandler?

    let servicesAssembly: ServicesAssembly
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController, servicesAssembly: ServicesAssembly) {
        self.navigationController = navigationController
        self.servicesAssembly = servicesAssembly
    }

    func start() {
        let recordsListAssembly = RecordsListAssembly(serviceAssembly: servicesAssembly)
        let vc = recordsListAssembly.build()
        vc.onSelectRecord = { [weak self] exercise in
            self?.showRecordDetail(for: exercise)
        }
        navigationController.setViewControllers([vc], animated: false)
    }
    
    private func showRecordDetail(for exercise: Exercise) {
        let workoutAssembly = WorkoutRecordDetailAssembly(serviceAssembly: servicesAssembly)
        let workoutVC = workoutAssembly.build(with: exercise)
        navigationController.pushViewController(workoutVC, animated: true)
    }
}
