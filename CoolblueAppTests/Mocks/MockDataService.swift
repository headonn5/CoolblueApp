//
//  MockDataService.swift
//  CoolblueAppTests
//
//  Created by Nishant Paul on 16/10/22.
//

import XCTest
@testable import CoolblueApp

class MockDataService: DataServiceProtocol {
    var error: AppError?
    var expectation: XCTestExpectation?
    var response: Any?
    
    func fetch<T>(api: APIResourceProtocol,
                  completionHandler: @escaping (Result<T, AppError>) -> Void) where T : Decodable {
        if let error = error {
            completionHandler(.failure(error))
        }
        else {
            guard let unwrappedResponse = response as? T else {
                let error = NSError(domain: "", code: 500, userInfo: ["description": "Response is not of type \(T.self)"])
                let result: Result<T, AppError> = .failure(.responseError(error: error))
                completionHandler(result)
                expectation?.fulfill()
                return
            }
            let result: Result<T, AppError> = .success(unwrappedResponse)
            completionHandler(result)
        }
        
        expectation?.fulfill()
    }
}
