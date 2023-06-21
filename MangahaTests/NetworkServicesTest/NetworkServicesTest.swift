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
        let address = AddressModel(address: Address(address1: "smouha", city: "alex", phone: "01004643544", countryName: "Egypt", country: "Egypt"))
        NetworkServices.postNewAddress(address: address) { customerAddress, error in
                   XCTAssertNotNil(customerAddress, "Customer address should not be nil")
                   XCTAssertNil(error, "Error should be nil")
                   myExpectation.fulfill()
               }
        waitForExpectations(timeout: 10.0 , handler: nil)
           }
    func testMakeDefaultAddresses() {

          let myExpectation = expectation(description: "Make default addresses expectation")


          let addressId = Constant.getDefaultAddressId()

     
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
        let addressId = Constant.getDefaultAddressId()
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
    func testGetProductInfo(){
        let myExpectation = expectation(description: "Waiting for api")
        NetworkServices.getProductInfo(baseUrl: Constant.productInfo(productId: 8398222688542)) { product in
            XCTAssertNotNil(product, "product should not be nil")
            myExpectation.fulfill()
        }

      waitForExpectations(timeout: 10.0 , handler: nil)
    }
    func testPostCustomer(){
        let myExpectation = expectation(description: "Waiting for response")
        let customer = userCustomer(customer: Customer(firstName: "abdallah", email: "gedo2@gmail.com", verifiedEmail: true, password: "12344567889", passwordConfirmation: "12344567889", sendEmailWelcome: true))
        NetworkServices.postCustomer(customer: customer) { customerResponse, error in
            XCTAssertNotNil(customerResponse, "Customer response should not be nil")
            XCTAssertNil(error, "Error should be nil")
            myExpectation.fulfill()
        }

      waitForExpectations(timeout: 10.0 , handler: nil)
    }
    func testPostDraftOrder(){
        let myExpectation = expectation(description: "Waiting for response")
        let lineItems = [LineItems(title: "aaa",price: "100",quantity: 1 , imageUrl: "aa")]
        NetworkServices.postDraftOrder(products: lineItems) { draftOrderResponse, error in
            XCTAssertNotNil(draftOrderResponse, "Draft order response should not be nil")
            XCTAssertNil(error, "Error should be nil")
            myExpectation.fulfill()
        }

      waitForExpectations(timeout: 10.0 , handler: nil)
    }
    func testGetDraftOrder(){
        let myExpectation = expectation(description: "Waiting for api")
        NetworkServices.getDraftOrder(id: 1119559778590) { draftOrderResponse, error in
            XCTAssertNotNil(draftOrderResponse, "Draft order response should not be nil")
            XCTAssertNil(error, "Error should be nil")
            myExpectation.fulfill()
        }

      waitForExpectations(timeout: 10.0 , handler: nil)
    }
    func testPostOrder(){
        let myExpectation = expectation(description: "Waiting for response")
        let order = Order(line_items: [LineItem(title: "a", price: "100", quantity: 1)],customer: CustomerId(id:Int(Constant.getCurrentCustomerId())) , created_at: "12")
        NetworkServices.postOrder(url: Constant.postOrder(), order: PostOrder(order: order)) { responseOrder, error in
            XCTAssertNotNil(responseOrder, "Order response should not be nil")
            XCTAssertNil(error, "Error should be nil")
            myExpectation.fulfill()
        }

      waitForExpectations(timeout: 10.0 , handler: nil)
    }
}

