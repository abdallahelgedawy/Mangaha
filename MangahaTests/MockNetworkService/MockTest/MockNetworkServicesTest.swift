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
            XCTAssertEqual(addressList.count, 0, "parseing Failed")
        }
    }
    
    func testMakeDeafultAddresses(){
        MockNetworkService.makeDeafultAddresses(adressId: ""){
            address,error  in
            guard let addressList = address else{
                XCTFail()
                return
            }
            XCTAssertNotNil(addressList , "parseing failed")
        }
    }
    
    func testGetAddressDetails(){
        MockNetworkService.getAddressDetails(){
            address,error  in
            guard let addressList = address else{
                XCTFail()
                return
            }
            XCTAssertNotNil(addressList , "parseing failed")
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
    
    func testPostNewAddress(){
        MockNetworkService.postNewAddress(address: AddressModel(address: Address())){
            address,error  in
            guard let addressList = address else{
                XCTFail()
                return
            }
            XCTAssertNotNil(addressList , "parseing failed")
        }
    }
    func testGetProductInfo(){
        MockNetworkService.getProductInfo(baseUrl: ""){
            products in
            guard let productList = products else{
                XCTFail()
                return
            }
            XCTAssertNotNil(productList , "parseing failed")
        }
    }
    func testPostCustomer(){
        MockNetworkService.postCustomer(customer: userCustomer(customer: Customer(firstName: "", email: "", verifiedEmail: true, password: "", passwordConfirmation: "", sendEmailWelcome: true))){
            products,error  in
            guard let productList = products else{
                XCTFail()
                return
            }
            XCTAssertNotNil(productList , "parseing failed")
        }
    }
    func testPostDraftOrder(){
        MockNetworkService.postDraftOrder(products: [LineItems()]){
            orders,error  in
            guard let ordersList = orders else{
                XCTFail()
                return
            }
            XCTAssertNotNil(ordersList , "parseing failed")
        }
    }
    func testGetDraftOrder(){
        MockNetworkService.getDraftOrder(id: 0){
            orders,error  in
            guard let ordersList = orders else{
                XCTFail()
                return
            }
            XCTAssertNotNil(ordersList , "parseing failed")
        }
    }
    func testPostOrder(){
        MockNetworkService.postOrder(url: "", order: PostOrder(order: Order())){
            orders,error  in
            guard let ordersList = orders else{
                XCTFail()
                return
            }
            XCTAssertNotNil(ordersList , "parseing failed")
        }
    }
}
