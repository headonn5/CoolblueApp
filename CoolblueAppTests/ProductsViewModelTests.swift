//
//  CoolblueAppTests.swift
//  CoolblueAppTests
//
//  Created by Nishant Paul on 16/10/22.
//

import XCTest
@testable import CoolblueApp

class ProductsViewModelTests: XCTestCase {
    
    var product: Product!
    
    override func setUpWithError() throws {
        let reviewInfo = ReviewInformation(reviewSummary: ReviewSummary(reviewAverage: 4.5, reviewCount: 100))
        product = Product(productId: 1,
                              productName: "Apple Macbook Pro 16 inch",
                              reviewInformation: reviewInfo,
                              USPs: ["usp 1", "usp 2"],
                              availabilityState: 1,
                              salesPriceIncVat: 879.0,
                              productImage: "https://image.coolblue.nl/300x750/products/943711",
                              coolbluesChoiceInformationTitle: nil,
                              promoIcon: nil,
                              nextDayDelivery: false,
                              listPriceIncVat: nil,
                              listPriceExVat: nil)
    }

    func testWhenValidResponseReceived_ProductsResponseUpdated() {
        let dataService = MockDataService()
        let imageService = MockImageService()
        dataService.expectation = XCTestExpectation(description: "Products response should be updated.")
        
        dataService.response = ProductsResponse(products: [product], currentPage: 1, pageSize: 1, totalResults: 1, pageCount: 1)
        
        // System under test
        let sut = ProductsViewModel(dataService: dataService, imageService: imageService)
        
        sut.fetchProducts()
        
        // Assert
        wait(for: [dataService.expectation!], timeout: 1.0)
        XCTAssertNotNil(sut.products, "Response products are not updated.")
        XCTAssertEqual(sut.products?.count, 1)
    }
    
    func testWhenInvalidResponseReceived_ErrorOccurs() {
        let dataService = MockDataService()
        let imageService = MockImageService()
        dataService.expectation = XCTestExpectation(description: "Products response should not be updated.")
        dataService.response = "Products"
        
        // System under test
        let sut = ProductsViewModel(dataService: dataService, imageService: imageService)
        
        sut.fetchProducts()
        
        // Assert
        wait(for: [dataService.expectation!], timeout: 1.0)
        XCTAssertNil(sut.products, "Products response should not be updated.")
    }

}
