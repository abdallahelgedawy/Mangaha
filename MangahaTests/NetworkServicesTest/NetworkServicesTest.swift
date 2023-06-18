//
//  NetworkServicesTest.swift
//  MangahaTests
//
//  Created by mariam adly on 18/06/2023.
//

import XCTest
@testable import Mangaha

final class NetworkServicesTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetBrands(){
        let myExpectation = expectation(description: "wait for my Api")
        NetworkServices.getBrands(baseUrl: Constant.allBrands()){
            brands in
            guard let brandList = brands?.smart_collections else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertGreaterThan(brandList.count, 0, "fail to catch data")
            myExpectation.fulfill()
        }
        waitForExpectations(timeout: 5,handler: nil)
    }
    
    func testGetProducts(){
        let myExpectation = expectation(description: "wait for my Api")
        NetworkServices.getProducts(baseUrl: Constant.allProducts()){
            products in
            guard let productList = products?.products else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertGreaterThan(productList.count, 0, "fail to catch data")
            myExpectation.fulfill()
        }
        waitForExpectations(timeout: 5,handler: nil)
    }
}
