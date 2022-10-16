//
//  MockNetworkService.swift
//  CoolblueAppTests
//
//  Created by Nishant Paul on 16/10/22.
//

import XCTest
@testable import CoolblueApp

class MockNetworkService: NetworkServiceProtocol {
    
    let data: Data?
    let response: HTTPURLResponse?
    let error: AppError?
    
    init(data: Data?, response: HTTPURLResponse?, error: AppError?) {
      self.data = data
      self.response = response
      self.error = error
    }
    
    func execute(resource: APIResourceProtocol, completionHandler: @escaping (Result<Data?, AppError>) -> Void) {
        if self.response?.statusCode == 200 {
          completionHandler(.success(data))
        }
        else {
            guard let error = error else {
                XCTFail("No Error Found.")
                return
            }
            completionHandler(.failure(error))
        }
    }
    
    
}
