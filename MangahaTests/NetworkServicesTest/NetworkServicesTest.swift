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
    
    func testGetAllAddressesForCustomer(){
        let myExpectation = expectation(description: "wait for my Api")
        NetworkServices.getAllAddressesForCustomer(){
            address,error  in
            guard let addressList = address else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertGreaterThan(addressList.count, 0, "fail to catch data")
            myExpectation.fulfill()
        }
        waitForExpectations(timeout: 5,handler: nil)
    }
    func testGetOrders(){
        let myExpectation = expectation(description: "wait for my Api")
        NetworkServices.getOrders(url: Constant.getOrder(customerId: Int(Constant.getCurrentCustomerId()) ?? 0)){
            order,error  in
            guard let ordersList = order?.orders else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertGreaterThan(ordersList.count, 0, "fail to catch data")
            myExpectation.fulfill()
        }
        waitForExpectations(timeout: 5,handler: nil)
    }
    func testPostNewAddress(){
        let myExpectation = expectation(description: "Wait for the response")
        let address = AddressModel(address: Address(address1: "smouha", city: "alex", phone: "01004643564", countryName: "Egypt", country: "Egypt"))
        NetworkServices.postNewAddress(address: address) { customerAddress, error in
                   XCTAssertNotNil(customerAddress, "Customer address should not be nil")
                   XCTAssertNil(error, "Error should be nil")
                   myExpectation.fulfill()
               }
        waitForExpectations(timeout: 10.0 , handler: nil)
           }
    func testMakeDefaultAddresses() {

          let myExpectation = expectation(description: "Make default addresses expectation")


          let addressId = "9221130649886"

     
          NetworkServices.makeDeafultAddresses(adressId: addressId) { (customerAddress, error) in

              XCTAssertNotNil(customerAddress, "Customer address should not be nil")
              XCTAssertNil(error, "Error should be nil")


              myExpectation.fulfill()
          }

          // Wait for the expectation to be fulfilled, with a timeout of 10 seconds
        waitForExpectations(timeout: 10.0 , handler: nil)
      }
    func testDeleteAddress(){
        let myExpectation = expectation(description: "Wait For delete")
        let addressId = "9221130649886"
        NetworkServices.deleteAddress(addressId: addressId) { address, error in
            XCTAssertNil(address, "Customer address should not be nil")
            XCTAssertNil(error, "Error should be nil")


            myExpectation.fulfill()
        }

      waitForExpectations(timeout: 10.0 , handler: nil)
        }
    func testgetAddressDetails(){
        let myExpectation = expectation(description: "Wait for api")
        NetworkServices.getAddressDetails { customerAddress, error in
            XCTAssertNotNil(customerAddress, "Customer address should not be nil")
            XCTAssertNil(error, "Error should be nil")
            myExpectation.fulfill()
        }

      waitForExpectations(timeout: 10.0 , handler: nil)
    }
}

