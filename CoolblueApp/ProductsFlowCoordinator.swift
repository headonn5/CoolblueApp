//
//  ProductsFlowCoordinator.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import Foundation
import UIKit

class ProductsFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let productsDependencyContainer: ProductsDependencyContainer
    
    init(navigationController: UINavigationController,
         productsDependencyContainer: ProductsDependencyContainer) {
        self.navigationController = navigationController
        self.productsDependencyContainer = productsDependencyContainer
    }
    
    func startProductsFlow() {
        let viewController = productsDependencyContainer.makeProductsViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
