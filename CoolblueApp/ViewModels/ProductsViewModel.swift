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
    
    private var query: String = ""
    private var currentPage: Int = 0
    private var totalPages: Int = 1
    private var hasMorePages: Bool {
        return currentPage < totalPages
    }
    private var nextPage: Int {
        return hasMorePages ? currentPage + 1 : currentPage
    }
    private var productsPages: [ProductsPage] = []
    
    init(dataService: DataServiceProtocol, imageService: ImageServiceProtocol) {
        self.dataService = dataService
        self.imageService = imageService
    }
    
    func fetchProducts(query: String, page: Int = 1) {
        self.query = query
        state = .loading
        let api = ProductsAPI(query: query, page: page)
        dataService.fetch(api: api) { [weak self] (result: Result<ProductsPage, AppError>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.currentPage = response.currentPage
                self.totalPages = response.pageCount
                var updatedProductsPages = self.productsPages.filter { productsPage in
                    productsPage.currentPage != response.currentPage
                }
                updatedProductsPages.append(response)
                
                self.productsPages = updatedProductsPages
                
                self.products =
                self.productsPages
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
        productsPages.removeAll()
        products?.removeAll()
    }
    
    func updateSearchResults(for query: String) {
        // Reset data for every new search
        resetData()
        fetchProducts(query: query)
    }
}
