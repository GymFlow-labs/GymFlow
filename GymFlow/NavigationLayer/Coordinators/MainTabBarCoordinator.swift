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
        
        // 2) Add Record (SwiftUI внутри UIKit)
        let addNav = UINavigationController()
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
        
        // 3) Records List
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
        let vc = HomeViewController()
        navigationController.setViewControllers([vc], animated: false)
    }
}

final class AddRecordCoordinator: Coordinator {
    var navigationController: UINavigationController


    var completionHandler: CoordinatorHandler?

    let servicesAssembly: ServicesAssembly
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController, servicesAssembly: ServicesAssembly) {
        self.navigationController = navigationController
        self.servicesAssembly = servicesAssembly
    }

    func start() {
        let addRecordAssembly = AddRecordAssembly(servicesAssembly: servicesAssembly)
        let rootView = addRecordAssembly.build()
        let hosting = UIHostingController(rootView: rootView)
        navigationController.setViewControllers([hosting], animated: false)
    }
}

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
        navigationController.setViewControllers([vc], animated: false)
    }
}
