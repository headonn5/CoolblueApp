//
//  AppDependencyContainer.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import Foundation

final class AppDependencyContainer {
    // Do lazy initialization of all flow dependencies to be used throughout the app
    lazy var productDataService: DataService = {
        return DataService(networkService: NetworkService())
    }()
    lazy var imageDataService: ImageService = {
        return ImageService(networkService: NetworkService())
    }()
    
    func makeProductsDependencyContainer() -> ProductsDependencyContainer {
        return ProductsDependencyContainer(dataService: productDataService, imageService: imageDataService)
    }
}
