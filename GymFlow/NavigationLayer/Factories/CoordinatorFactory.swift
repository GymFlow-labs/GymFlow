//
//  CoordinatorFactory.swift
//  GymFlow
//
//  Created by Artem Kriukov on 19.10.2025.
//

import UIKit

struct CoordinatorFactory {
    
    static func makeAppCoordinator(
        window: UIWindow,
        servicesAssembly: ServicesAssembly
    ) -> AppCoordinator {
        AppCoordinator(window: window, servicesAssembly: servicesAssembly)
    }
    
    static func makeTabBarCoordinator(
        servicesAssembly: ServicesAssembly
    ) -> MainTabBarCoordinator {
        MainTabBarCoordinator(servicesAssembly: servicesAssembly)
    }
    
    static func makeHomeCoordinator(
        navigationController: UINavigationController,
        servicesAssembly: ServicesAssembly
    ) -> HomeCoordinator {
        HomeCoordinator(navigationController: navigationController, servicesAssembly: servicesAssembly)
    }
    
    static func makeAddRecordCoordinator(
        navigationController: UINavigationController,
        servicesAssembly: ServicesAssembly
    ) -> AddRecordCoordinator {
        AddRecordCoordinator(navigationController: navigationController, servicesAssembly: servicesAssembly)
    }
    
    static func makeRecordListCoordinator(
        navigationController: UINavigationController,
        servicesAssembly: ServicesAssembly
    ) -> RecordsListCoordinator {
        RecordsListCoordinator(navigationController: navigationController, servicesAssembly: servicesAssembly)
    }
}
