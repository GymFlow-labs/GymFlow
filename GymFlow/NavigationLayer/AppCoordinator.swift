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
    private let window: UIWindow
    private var tabBarCoordinator: MainTabBarCoordinator?
    var completionHandler: CoordinatorHandler?

    init(
        window: UIWindow,
        servicesAssembly: ServicesAssembly
    ) {
        self.window = window
        self.servicesAssembly = servicesAssembly
    }
    
    func start() {
        showMainFlow()
    }
    
    private func showMainFlow() {
        childCoordinators.removeAll()
        tabBarCoordinator = CoordinatorFactory.makeTabBarCoordinator(servicesAssembly: servicesAssembly)
        
        guard let tabBarCoordinator else {
            print("[AppCoordinator -> showMainFlow]: Ошибка инициализации MainTabBarCoordinator")
            return
        }
        
        window.rootViewController = tabBarCoordinator.rootViewController
        window.makeKeyAndVisible()
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
    }
}
