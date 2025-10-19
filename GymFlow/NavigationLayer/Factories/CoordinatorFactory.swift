//
//  CoordinatorFactory.swift
//  GymFlow
//
//  Created by Artem Kriukov on 19.10.2025.
//

import UIKit

struct CoordinatorFactory {
    
    static func makeAppCoordinator(
        navController: UINavigationController,
        servicesAssembly: ServicesAssembly
    ) -> AppCoordinator {
        AppCoordinator(navigationController: navController, servicesAssembly: servicesAssembly)
    }
    
    static func makeMainCoordinator(
        servicesAssembly: ServicesAssembly,
        navController: UINavigationController
    ) -> MainFlowCoordinator {
        MainFlowCoordinator(servicesAssembly: servicesAssembly, navigationController: navController)
    }
    
}
