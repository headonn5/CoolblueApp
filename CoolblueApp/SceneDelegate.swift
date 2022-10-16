//
//  SceneDelegate.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        let dependencyContainer = AppDependencyContainer()
        let mainCoordinator = AppFlowCoordinator(navigationController: navigationController,
                                                 appDependencyContainer: dependencyContainer)
        mainCoordinator.startAppFlow()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}
