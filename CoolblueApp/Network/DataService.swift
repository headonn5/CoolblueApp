//
//  DataService.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import Foundation

protocol DataServiceProtocol {
    func fetch<T: Decodable>(api: APIResourceProtocol,
                  completionHandler: @escaping (Result<T, AppError>) -> Void)
}

class DataService: DataServiceProtocol {
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetch<T: Decodable>(api: APIResourceProtocol,
                  completionHandler: @escaping (Result<T, AppError>) -> Void) {
        networkService.execute(resource: api) { [self] result in
            switch result {
            case .success(let data):
                let decodedData: Result<T, AppError> = self.decode(data: data)
                completionHandler(decodedData)
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    private func decode<T: Decodable>(data: Data?) -> Result<T, AppError> {
        do {
            guard let data = data else {
                return .failure(.voidResponseError)
            }
            let decodedData: T = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch let e {
            print(e)
            return .failure(.parseError)
        }
    }
}
