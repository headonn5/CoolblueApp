//
//  ImageService.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import Foundation

protocol ImageServiceProtocol {
    func fetchImage(with api: APIResourceProtocol, completion: @escaping (Result<Data, AppError>) -> Void)
}

struct ImageService: ImageServiceProtocol {
    let networkService: NetworkServiceProtocol
    
    func fetchImage(with api: APIResourceProtocol, completion: @escaping (Result<Data, AppError>) -> Void) {
        networkService.execute(resource: api) { (result: Result<Data?, AppError>) in
            switch result {
            case .success(let data):
                guard let data = data else {
                    print("No data received")
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
