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
    @Published private(set) var state: ProductsViewModelState = .finished
    
    var query: String = ""
    var currentPage: Int = 0
    var totalPages: Int = 1
    var hasMorePages: Bool {
        return currentPage < totalPages
    }
    var nextPage: Int {
        return hasMorePages ? currentPage + 1 : currentPage
    }
    private var responseProducts: [ProductsResponse] = []
    
    init(dataService: DataServiceProtocol, imageService: ImageServiceProtocol) {
        self.dataService = dataService
        self.imageService = imageService
    }
    
    func fetchProducts(query: String, page: Int = 1) {
        self.query = query
        state = .loading
        let api = ProductsAPI(query: query, page: page)
        dataService.fetch(api: api) { [weak self] (result: Result<ProductsResponse, AppError>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.currentPage = response.currentPage
                self.totalPages = response.pageCount
                var newResponseProducts = self.responseProducts.filter { responseProduct in
                    responseProduct.currentPage != response.currentPage
                }
                newResponseProducts.append(response)
                
                self.responseProducts = newResponseProducts
                
                self.products =
                self.responseProducts
                    .flatMap({ $0.products })
                    .map({ ProductItemViewModel(product: $0, imageService: self.imageService) })
                
                self.state = .finished
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }
    
    func fetchNextPage() {
        guard hasMorePages else { return }
        fetchProducts(query: query, page: nextPage)
    }
    
    private func resetData() {
        currentPage = 0
        totalPages = 1
        responseProducts.removeAll()
        products?.removeAll()
    }
    
    func updateSearchResults(for query: String) {
        // Reset data for every new search
        resetData()
        fetchProducts(query: query)
    }
}
