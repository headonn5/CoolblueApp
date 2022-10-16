//
//  MockImageService.swift
//  CoolblueAppTests
//
//  Created by Nishant Paul on 17/10/22.
//

import XCTest
@testable import CoolblueApp

class MockImageService: ImageServiceProtocol {
    var error: AppError?
    var imageData = Data()
    var expectation: XCTestExpectation?
    var response: Any?
    
    func fetchImage(with api: APIResourceProtocol, completion: @escaping (Result<Data, AppError>) -> Void) {
        if let error = error {
            completion(.failure(error))
        }
        else {
            completion(.success(imageData))
        }
        
        expectation?.fulfill()
    }
}
