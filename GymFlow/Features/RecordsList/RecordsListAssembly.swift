//
//  RecordsListAssembly.swift
//  GymFlow
//
//  Created by Artem Kriukov on 14.10.2025.
//

import Foundation

struct RecordsListAssembly {
    private let serviceAssembly: ServicesAssembly
    
    init(serviceAssembly: ServicesAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func build() -> RecordsListViewController {
        let exerciseService = serviceAssembly.exercise1RMRepositoriesImpl
        let viewModel = RecordsListViewModel(exercise1RMRepositories: exerciseService)
        let viewController = RecordsListViewController(viewModel: viewModel)
        return viewController
    }
}
