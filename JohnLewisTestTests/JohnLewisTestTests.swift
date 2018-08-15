//
//  JohnLewisTestTests.swift
//  JohnLewisTestTests
//
//  Created by Kim Summerskill on 14/08/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import XCTest
@testable import JohnLewisTest

class JohnLewisTestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchResult() {
        
        let bundle = Bundle(for: JohnLewisTestTests.self)
        
        if let path = bundle.path(forResource: "DishwasherSearchResult", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let result = try data.decodeDataToObjects(with: ProductsService.RequestType.productSearch)
                
                // test object graph fron json
                XCTAssertTrue(result is ProductsModel)
                
                if let result = result as? ProductsModel {
                    XCTAssertTrue(result.items.count == 20)
                    XCTAssertNotNil(result.model(at: result.items.count-1))
                    XCTAssertNil(result.model(at: result.items.count))
                }
            }
            catch {
                XCTFail("Failed to decode DishwasherSearchResult.json into objects")
            }
        }
    }
    
    // Test various types of 'no result' or 'no json' or 'bad result'
    func testNoSearchResult() {
        let bundle = Bundle(for: JohnLewisTestTests.self)
        if let path = bundle.path(forResource: "DishwasherSearchNoResult", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                XCTAssertThrowsError(try data.decodeDataToObjects(with: ProductsService.RequestType.productSearch))
            }
            catch {
                
            }
        }
    }
    
    func testCurrencyConversion() {
        let ukcode = "GBP"
        let val = 100.0
    
        XCTAssertEqual(Conversion().currencyString(with: ukcode, value: val), "£100.00")
        
        let usacode = "USD"
        
        XCTAssertEqual(Conversion().currencyString(with: usacode, value: val), "$100.00")
    }
    
    // Ensure the URL is formatted and encoded correctly and that a bad URL is handled
    func testProductsServiceURL() {
        let productsService = ProductsService()
        
        // Test URL format
        XCTAssertNil(productsService.urlFor(requestType: ProductsService.RequestType.productSearch, context: nil))
        
         // Ensure not allowed character is percent encoded
        XCTAssertTrue(productsService.urlFor(requestType: ProductsService.RequestType.productSearch, context: "|")?.absoluteString.range(of: "|") == nil)
        
        // Ensure normal search produces URL
        XCTAssertNotNil(productsService.urlFor(requestType: ProductsService.RequestType.productSearch, context: "dishwasher"))
        
    }
    
    // Note: As this is a test I am not sure if I shoulod be exhaustive or just indicate what I would do here.
    // I would normally create a protocol for the service that I could use for this test and mimic the behavior of the
    // service failure routes.
    func testServiceFailResponse() {
        
    }
}
