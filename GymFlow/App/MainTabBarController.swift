//
//  TabBarController.swift
//  GymFlow
//
//  Created by Artem Kriukov on 05.10.2025.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        let addRecordVC = AddRecordViewController()
        let recordsListVC = RecordsListViewController()

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


