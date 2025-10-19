//
//  SceneDelegate.swift
//  GymFlow
//
//  Created by Artem Kriukov on 05.10.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    let servicesAssembly = ServicesAssembly(
        networkClient: NetworkClient(),
        coreDataStack: CoreDataStack()
    )
    
    private var appCoordinator: Coordinator?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
            
            let nav = UINavigationController()
            appCoordinator = CoordinatorFactory.makeAppCoordinator(
                navController: nav,
                servicesAssembly: servicesAssembly
            )
            
            guard let windowScene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: windowScene)
            
            window?.rootViewController = nav
            window?.frame = windowScene.coordinateSpace.bounds
            window?.makeKeyAndVisible()
            appCoordinator?.start()
        }
}
