//
//  AppCoordinator.swift
//  GymFlow
//
//  Created by Artem Kriukov on 19.10.2025.
//

import UIKit

final class AppCoordinator: Coordinator {
    private var servicesAssembly: ServicesAssembly
    private var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    var completionHandler: CoordinatorHandler?

    init(
        navigationController: UINavigationController,
        servicesAssembly: ServicesAssembly
    ) {
        self.navigationController = navigationController
        self.servicesAssembly = servicesAssembly
    }
    
    func start() {
        showMainFlow()
    }
    
    private func showMainFlow() {
        childCoordinators.removeAll()
        let mainFlowCoordinator = MainFlowCoordinator(
            servicesAssembly: servicesAssembly,
            navigationController: navigationController
        )
        childCoordinators.append(mainFlowCoordinator)
        mainFlowCoordinator.completionHandler = { [weak self] in self?.showMainFlow() }
        navigationController.setViewControllers([], animated: false)
        mainFlowCoordinator.start()
    }
}
