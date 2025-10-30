//
//  ResultsListAssembly.swift
//  GymFlow
//
//  Created by Artem Kriukov on 14.10.2025.
//

import Foundation

struct ResultsListAssembly {
    private let serviceAssembly: ServicesAssembly
    
    init(serviceAssembly: ServicesAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func build() -> ResultsListViewController {
        let exerciseService = serviceAssembly.exercise1RMRepositoriesImpl
        let viewModel = RecordsListViewModel(exercise1RMRepositories: exerciseService)
        let viewController = ResultsListViewController(
            viewModel: viewModel,
            servicesAssembly: serviceAssembly
        )
        return viewController
    }
}
