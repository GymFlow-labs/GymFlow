//
//  MainTabBarCoordinator.swift
//  GymFlow
//
//  Created by Artem Kriukov on 19.10.2025.
//
import SwiftUI

import UIKit

final class MainTabBarCoordinator: Coordinator {
    private let servicesAssembly: ServicesAssembly
    private let tabBarController = UITabBarController()
    
    private var childCoordinators: [Coordinator] = []
    
    var completionHandler: CoordinatorHandler?
    var rootViewController: UIViewController { tabBarController }
    
    init(
        servicesAssembly: ServicesAssembly
    ) {
        self.servicesAssembly = servicesAssembly
    }
    
    func start() {
        setUpTabBar()
    }
    
}

private extension MainTabBarCoordinator {
    func makeTab(for tab: Tabs) -> UINavigationController {
        let navigation = UINavigationController()
        
        let coordinator = tab.makeTabsCoordinator(
            navigationController: navigation,
            servicesAssembly: servicesAssembly
        )
        childCoordinators.append(coordinator)
        coordinator.start()
        
        navigation.tabBarItem = UITabBarItem(
            title: tab.title,
            image: tab.image,
            tag: tab.tag
        )
        
        return navigation
    }
    
    func setUpTabBar() {
        let tabs: [Tabs] = [.home, .add, .records]
        tabBarController.viewControllers = tabs.map { makeTab(for: $0) }
    }
}
