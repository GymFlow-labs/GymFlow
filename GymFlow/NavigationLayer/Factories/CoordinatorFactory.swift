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
}
