//
//  DataServiceTests.swift
//  CoolblueAppTests
//
//  Created by Nishant Paul on 17/10/22.
//

import XCTest
@testable import CoolblueApp

class DataServiceTests: XCTestCase {
    
    private var urlResponse: HTTPURLResponse?

    override func setUpWithError() throws {
        urlResponse = HTTPURLResponse(url: URL(string: "www.test.com")!, statusCode: 200, httpVersion: "1.1", headerFields: [:])
    }

    override func tearDownWithError() throws {
        urlResponse = nil
    }

    func testWhenRequestFails_ErrorOccurs() {
        let error: AppError = AppError.responseError(error: NSError(domain: "", code: 400, userInfo: nil))
        let mockNetworkService = MockNetworkService(data: nil, response: nil, error: error)
        let sut = DataService(networkService: mockNetworkService)
        
        let expectation = XCTestExpectation(description: "The request is expected to return response Error")
        
        sut.fetch(api: MockApiResource(path: "testPath")) { (result: Result<ProductsResponse, AppError>) in
            do {
                let _ = try result.get()
                XCTFail("The Data Service request should throw an error.")
            }
            catch let error {
                guard case AppError.responseError(error: _) = error else {
                    XCTFail("The request should throw .responseError")
                    return
                }
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testWhenGivenValidData_DecodeSuccessfully() {
        guard let bundlePath = Bundle(for: type(of: self)).path(forResource: "ValidMockResponse", ofType: "json") else {
            XCTFail("ValidMockResponse file not found.")
            return
        }
        guard let data = try? String(contentsOfFile: bundlePath).data(using: .utf8) else {
            XCTFail("Error fetching contents of ValidMockResponse file.")
            return
        }
        let mockNetworkService = MockNetworkService(data: data, response: urlResponse, error: nil)
        let sut = DataService(networkService: mockNetworkService)
        let expectation = XCTestExpectation(description: "The request is expected to parse data successfully.")
        let expectedTitle = "Apple iPhone 6 32GB Grijs"
        
        sut.fetch(api: MockApiResource(path: "testPath")) { (result: Result<ProductsResponse, AppError>) in
            guard let decodedObject = try? result.get() else {
                XCTFail("The request should decode response successfully.")
                return
            }
            XCTAssertEqual(decodedObject.products[0].productName, expectedTitle)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testWhenGivenInvalidData_DecodingErrorOccurs() {
        guard let bundlePath = Bundle(for: type(of: self)).path(forResource: "InvalidMockResponse", ofType: "json") else {
            XCTFail("InvalidMockResponse file not found.")
            return
        }
        guard let data = try? String(contentsOfFile: bundlePath).data(using: .utf8) else {
            XCTFail("Error fetching contents of InvalidMockResponse file.")
            return
        }
        let mockNetworkService = MockNetworkService(data: data, response: urlResponse, error: nil)
        let sut = DataService(networkService: mockNetworkService)
        let expectation = XCTestExpectation(description: "The request is expected to throw parse error.")
        
        sut.fetch(api: MockApiResource(path: "testPath")) { (result: Result<ProductsResponse, AppError>) in
            do {
                let _ = try result.get()
                XCTFail("The request should throw parse error.")
                return
            }
            catch let error {
                guard case AppError.parseError = error else {
                    XCTFail("The request did not throw parse error")
                    return
                }
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
