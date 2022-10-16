//
//  ProductsDependencyContainer.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import Foundation
import UIKit

class ProductsDependencyContainer {
    let dataService: DataServiceProtocol
    let imageService: ImageServiceProtocol
    
    init(dataService: DataServiceProtocol, imageService: ImageServiceProtocol) {
        self.dataService = dataService
        self.imageService = imageService
    }
    
    func makeProductsFlowCoordinator(navigationController: UINavigationController) -> ProductsFlowCoordinator {
        return ProductsFlowCoordinator(navigationController: navigationController, productsDependencyContainer: self)
    }
    
    func makeProductsViewController() -> ProductsViewController {
        let viewModel = ProductsViewModel(dataService: dataService,
                                          imageService: imageService)
        return ProductsViewController(viewModel: viewModel)
    }
}
