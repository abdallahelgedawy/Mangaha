//
//  MockNetworkServicesTest.swift
//  MangahaTests
//
//  Created by mariam adly on 19/06/2023.
//

import XCTest
@testable import Mangaha

final class MockNetworkServicesTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetBrands(){
        MockNetworkService.getBrands(baseUrl: Constant.allBrands()){
            brands in
            guard let brandList = brands?.smart_collections else{
                XCTFail()
                return
            }
            XCTAssertGreaterThan(brandList.count, 0, "parseing Failed")
        }
    }
    
    func testGetProducts(){
        MockNetworkService.getProducts(baseUrl: Constant.allProducts()){
            products in
            guard let productList = products?.products else{
                XCTFail()
                return
            }
            XCTAssertGreaterThan(productList.count, 0, "parseing Failed")
        }
    }
    
    func testGetAllAddressesForCustomer(){
        MockNetworkService.getAllAddressesForCustomer(){
            address,error  in
            guard let addressList = address else{
                XCTFail()
                return
            }
            XCTAssertGreaterThan(addressList.count, 0, "parseing Failed")
        }
    }
    func testGetOrders(){
        let myExpectation = expectation(description: "waiting for api")
        MockNetworkService.getOrders(url: Constant.getOrder(customerId: Int(Constant.getCurrentCustomerId()) ?? 0)){
            order,error  in
            if let error = error {
                      XCTFail("Error occurred: \(error.localizedDescription)")
                      myExpectation.fulfill()
                      return
                  }
            guard let ordersList = order?.orders else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertGreaterThan(ordersList.count, 0, "parseing Failed")
            myExpectation.fulfill()
            
        }
        waitForExpectations(timeout: 10.0,handler: nil)
    }
}
