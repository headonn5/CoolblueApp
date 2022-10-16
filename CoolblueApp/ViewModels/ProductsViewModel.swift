//
//  ProductsViewModel.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import Foundation

enum ProductsViewModelState {
    case loading
    case finished
    case error(_ error: Error)
}

class ProductsViewModel: ObservableObject {
    let dataService: DataServiceProtocol
    let imageService: ImageServiceProtocol
    @Published private(set) var products: [ProductItemViewModel]?
    @Published private(set) var state: ProductsViewModelState = .loading
    
    init(dataService: DataServiceProtocol, imageService: ImageServiceProtocol) {
        self.dataService = dataService
        self.imageService = imageService
    }
    
    func fetchProducts() {
        state = .loading
        let api = ProductsAPI(query: "apple", page: 1)
        dataService.fetch(api: api) { [weak self] (result: Result<ProductsResponse, AppError>) in
            guard let self = self else { return }
            switch result {
            case .success(let responseJSON):
                self.products = responseJSON.products.map({ ProductItemViewModel(product: $0, imageService: self.imageService) })
                self.state = .finished
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }
}
