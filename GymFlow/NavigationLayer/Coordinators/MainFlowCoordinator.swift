//
//  MainFlowCoordinator.swift
//  GymFlow
//
//  Created by Artem Kriukov on 19.10.2025.
//

import UIKit

final class MainFlowCoordinator: Coordinator {
    private let servicesAssembly: ServicesAssembly
    private var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    var completionHandler: CoordinatorHandler?

    init(
        servicesAssembly: ServicesAssembly,
        navigationController: UINavigationController
    ) {
        self.servicesAssembly = servicesAssembly
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = MainTabBarController(servicesAssembly: servicesAssembly)
        navigationController.setViewControllers([tabBarController], animated: false)
    }

}
