//
//  NetworkService.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import Foundation

protocol NetworkServiceProtocol {
    func execute(resource: APIResourceProtocol, completionHandler: @escaping (Result<Data?, AppError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func execute(resource: APIResourceProtocol, completionHandler: @escaping (Result<Data?, AppError>) -> Void) {
        // Fetch url
        do {
            let request = try resource.fetchURLRequest()
            execute(request: request, completionHandler: completionHandler)
        }
        catch {
            completionHandler(.failure(.invalidURL))
        }
    }
    
    private func execute(request: URLRequest, completionHandler: @escaping(Result<Data?, AppError>) -> Void) {
        urlSession.dataTask(with: request) { (data, response, error) in
            // Handle Errors
            if let error = error {
                completionHandler(.failure(.responseError(error: error)))
            }
            else {
                // Handle success
                completionHandler(.success(data))
            }
        }.resume()
    }
}
