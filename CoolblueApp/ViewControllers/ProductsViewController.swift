//
//  ProductsViewController.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import UIKit
import Combine

class ProductsViewController: UIViewController, AlertProtocol {
    
    let viewModel: ProductsViewModel
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barStyle = .default
        searchBar.placeholder = "Search Product..."
        searchBar.isTranslucent = true
        return searchBar
    }()
    private let tableview: UITableView = .init()
    private var bindings = Set<AnyCancellable>()
    
    init(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = searchBar
        
        searchBar.delegate = self
        tableview.dataSource = self
        tableview.delegate = self
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableview)
        
        setupConstraints()
        
        tableview.register(ProductTableViewCell.self,
                           forCellReuseIdentifier: ProductTableViewCell.self.description())
        
        // Set up view model bindings
        setUpBindings()
    }
    
    private func setupConstraints() {
        // Products tableview constraints
        NSLayoutConstraint.activate([
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setUpBindings() {
        viewModel.$products
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableview.reloadData()
            }
            .store(in: &bindings)

        viewModel.$state
            .receive(on: RunLoop.main)
            .sink { receivedValue in
                handleViewModelState(receivedValue)
            }
            .store(in: &bindings)
        
        func handleViewModelState(_ state: ProductsViewModelState) {
            switch state {
            case .loading:
                SpinnerView.showSpinner(on: view)
            case .finished:
                SpinnerView.hideSpinner()
            case .error(let error):
                SpinnerView.hideSpinner()
                showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
}

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = ProductTableViewCell.self.description()
        let cell = tableview.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath)
        guard let cell = cell as? ProductTableViewCell,
              let products = viewModel.products else {
                    return cell
              }
       
        // Configure cell
        let productViewModel = products[indexPath.row]
        cell.configure(with: productViewModel)
        
        // Load next page
        if indexPath.row == products.count - 1 {
            viewModel.fetchNextPage()
        }
        
        return cell
    }
}

extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ProductsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Fetch products
        guard let queryString = searchBar.text else { return }
        viewModel.updateSearchResults(for: queryString)
    }
}
