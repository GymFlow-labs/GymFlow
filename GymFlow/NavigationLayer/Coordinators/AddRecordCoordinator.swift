//
//  AddRecordCoordinator.swift
//  GymFlow
//
//  Created by Artem Kriukov on 19.10.2025.
//

import SwiftUI

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
