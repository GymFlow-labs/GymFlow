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
#warning("создание контролеров через фабрику!")
private extension MainTabBarCoordinator {
    func setUpTabBar() {
        let homeNav = UINavigationController()
        let homeCoordinator = HomeCoordinator(
            navigationController: homeNav,
            servicesAssembly: servicesAssembly
        )
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
        homeNav.tabBarItem = UITabBarItem(
            title: "Главная",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        
        let addNav = UINavigationController()
        addNav.navigationItem.largeTitleDisplayMode = .always
        addNav.navigationBar.prefersLargeTitles = true
        let addCoordinator = AddRecordCoordinator(
            navigationController: addNav,
            servicesAssembly: servicesAssembly
        )
        childCoordinators.append(addCoordinator)
        addCoordinator.start()
        addNav.tabBarItem = UITabBarItem(
            title: "Add",
            image: UIImage(systemName: "calendar.circle"),
            tag: 1
        )
        
        let recordsNav = UINavigationController()
        let recordsCoordinator = RecordsListCoordinator(
            navigationController: recordsNav,
            servicesAssembly: servicesAssembly
        )
        childCoordinators.append(recordsCoordinator)
        recordsCoordinator.start()
        recordsNav.tabBarItem = UITabBarItem(
            title: "List",
            image: UIImage(systemName: "person.circle.fill"),
            tag: 2
        )
        
        tabBarController.viewControllers = [homeNav, addNav, recordsNav]
    }
}
