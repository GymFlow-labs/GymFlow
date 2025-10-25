//
//  HomeCoordinator.swift
//  GymFlow
//
//  Created by Artem Kriukov on 19.10.2025.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController

    var completionHandler: CoordinatorHandler?

    let servicesAssembly: ServicesAssembly
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController, servicesAssembly: ServicesAssembly) {
        self.navigationController = navigationController
        self.servicesAssembly = servicesAssembly
    }

    func start() {
        let vc = AddSelectionViewController()
        navigationController.setViewControllers([vc], animated: false)
    }
}
