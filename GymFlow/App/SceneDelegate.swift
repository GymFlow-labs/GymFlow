//
//  SceneDelegate.swift
//  GymFlow
//
//  Created by Artem Kriukov on 05.10.2025.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private var appCoordinator: Coordinator?
    private let servicesAssembly = ServicesAssembly(
        networkClient: NetworkClient(),
        coreDataStack: CoreDataStack()
    )    
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        appCoordinator = CoordinatorFactory.makeAppCoordinator(
                window: window,
                servicesAssembly: servicesAssembly
            )
        self.window = window
        appCoordinator?.start()
    }
}
