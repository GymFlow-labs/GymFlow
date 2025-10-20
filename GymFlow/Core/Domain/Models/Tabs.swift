//
//  Tabs.swift
//  GymFlow
//
//  Created by Artem Kriukov on 20.10.2025.
//

import UIKit

enum Tabs {
    case home
    case add
    case records
    
    var title: String {
        switch self {
        case .home: return "Главная"
        case .add: return "Добавить"
        case .records: return "Рекорды"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .home: return UIImage(systemName: "house")
        case .add: return UIImage(systemName: "calendar.circle")
        case .records: return UIImage(systemName: "person.circle.fill")
        }
    }
    
    var tag: Int {
        switch self {
        case .home: return 0
        case .add: return 1
        case .records: return 2
        }
    }
}

extension Tabs {
    func makeTabsCoordinator(
        navigationController: UINavigationController,
        servicesAssembly: ServicesAssembly
    ) -> Coordinator {
        switch self {
        case .home:
            return CoordinatorFactory.makeHomeCoordinator(
                navigationController: navigationController,
                servicesAssembly: servicesAssembly
            )
        case .add:
            return CoordinatorFactory.makeAddRecordCoordinator(
                navigationController: navigationController,
                servicesAssembly: servicesAssembly
            )
        case .records:
            return CoordinatorFactory.makeRecordListCoordinator(
                navigationController: navigationController,
                servicesAssembly: servicesAssembly
            )
        }
    }
}
