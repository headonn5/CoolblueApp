//
//  AppFlowCoordinator.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import Foundation
import UIKit

/* Though using Coordinators for this small project could be an overkill,
   but it is a great tool to extend the current app to multiple screens.
   I have used this to showcase the extensibility of the app. */
class AppFlowCoordinator {
    private let navigationController: UINavigationController
    private let appDependencyContainer: AppDependencyContainer
    
    init(navigationController: UINavigationController,
         appDependencyContainer: AppDependencyContainer) {
        self.navigationController = navigationController
        self.appDependencyContainer = appDependencyContainer
    }
    
    func startAppFlow() {
        let productsDependencyContainer = appDependencyContainer.makeProductsDependencyContainer()
        let productsFlowCoordinator = productsDependencyContainer.makeProductsFlowCoordinator(navigationController: navigationController)
        productsFlowCoordinator.startProductsFlow()
        
    }
}
