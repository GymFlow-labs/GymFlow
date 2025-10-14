//
//  TabBarController.swift
//  GymFlow
//
//  Created by Artem Kriukov on 05.10.2025.
//

import SwiftUI
import UIKit

final class MainTabBarController: UITabBarController {

    var servicesAssembly: ServicesAssembly
    
    // MARK: - Init
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        let addRecordAssembly = AddRecordAssembly(servicesAssembly: servicesAssembly)
        let addRecordView = addRecordAssembly.build()
        let addRecordVC = UIHostingController(rootView: addRecordView)

        let recordsListAssembly = RecordsListAssembly(serviceAssembly: servicesAssembly)
        let recordsListVC = recordsListAssembly.build()

        viewControllers = [
            addRecordVC,
            recordsListVC
        ]

        addRecordVC.tabBarItem = UITabBarItem(
            title: "Add",
            image: UIImage(systemName: "calendar.circle"),
            tag: 0
        )

        recordsListVC.tabBarItem = UITabBarItem(
            title: "List",
            image: UIImage(systemName: "person.circle.fill"),
            tag: 1
        )
    }
}
