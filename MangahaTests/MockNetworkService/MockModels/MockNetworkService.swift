//
//  MockNetworkService.swift
//  MangahaTests
//
//  Created by mariam adly on 19/06/2023.
//

import Foundation
@testable import Mangaha

class MockNetworkService : NetworkServiceProtocol {
    
    static func getBrands(baseUrl: String, completionHandler: @escaping (Mangaha.Brands?) -> Void) {
        do{
            let result = try JSONDecoder().decode(Brands.self, from: MockBrandsResponse.brandsResponse.data(using: .utf8)!)
            completionHandler(result)
        }catch let error{
            print(error.localizedDescription)
            completionHandler(nil)
        }
    }
    
    static func getProducts(baseUrl: String, completionHandler: @escaping (Mangaha.Product?) -> Void) {
        do{
            let result = try JSONDecoder().decode(Product.self, from: MockProductsResponse.productsResponse.data(using: .utf8)!)
            completionHandler(result)
        }catch let error{
            print(error.localizedDescription)
            completionHandler(nil)
        }
    }
    
    static func getAllAddressesForCustomer(compelitionHandler: @escaping ([Mangaha.CustomerAddress]?, Error?) -> Void) {
        do{
            let result = try JSONDecoder().decode(GetAddressModel.self, from: MockCustomerAdressResponse.customerAdressResponse.data(using: .utf8)!)
            compelitionHandler(result.addresses, nil)
        }catch let error{
            print(error.localizedDescription)
            compelitionHandler(nil,error)
        }
    }
    
    static func getOrders(url: String, completionHandler: @escaping (GetOrder?, Error?) -> Void) {
        do{
            let result = try JSONDecoder().decode(GetOrder.self, from: MockOrderResponse.orderResponse.data(using: .utf8)!)
            completionHandler(result, nil)
        }catch let error{
            print(error.localizedDescription)
            completionHandler(nil,error)
        }
    }
    static func makeDeafultAddresses(adressId: String, compelitionHandler: @escaping (CustomerAddress?, Error?) -> Void) {
        do{
            let result = try JSONDecoder().decode(PostAdreesResponse.self, from: MockDefaultAddressResponse.defaultAddress.data(using: .utf8)!)
            compelitionHandler(result.customerAddress, nil)
        }catch let error{
            print(error.localizedDescription)
            compelitionHandler(nil,error)
        }
    }
    
    static func getAddressDetails(compelitionHandler: @escaping (CustomerAddress?, Error?) -> Void) {
        do{
            let result = try JSONDecoder().decode(PostAdreesResponse.self, from: MockDefaultAddressResponse.defaultAddress.data(using: .utf8)!)
            compelitionHandler(result.customerAddress, nil)
        }catch let error{
            print(error.localizedDescription)
            compelitionHandler(nil,error)
        }
    }
    static func postNewAddress(address: AddressModel, compelitionHandler: @escaping (CustomerAddress?, Error?) -> Void) {
        do{
            let result = try JSONDecoder().decode(PostAdreesResponse.self, from: MockDefaultAddressResponse.defaultAddress.data(using: .utf8)!)
            compelitionHandler(result.customerAddress, nil)
        }catch let error{
            print(error.localizedDescription)
            compelitionHandler(nil,error)
        }
    }
  
    static func getProductInfo(baseUrl: String, completionHandler: @escaping (myProduct?) -> Void) {
        do{
            let result = try JSONDecoder().decode(myProduct.self, from: MockProductsResponse.productInfo.data(using: .utf8)!)
            completionHandler(result)
        }catch let error{
            print(error.localizedDescription)
            completionHandler(nil)
        }
    }
    static func postCustomer(customer: userCustomer, completionHandler: @escaping (ResponseCustomer?, Error?) -> Void) {
        do{
            let result = try JSONDecoder().decode(ResponseUser.self, from: MockCustomerResponse.customerResponse.data(using: .utf8)!)
            completionHandler(result.customer,nil)
        }catch let error{
            print(error.localizedDescription)
            completionHandler(nil,error)
        }
    }
    static func postDraftOrder(products: [LineItems], completionHandler: @escaping (DraftOrderResponse?, Error?) -> Void) {
        do{
            let result = try JSONDecoder().decode(DraftOrderResponse.self, from: MockOrderResponse.draftOrder.data(using: .utf8)!)
            completionHandler(result,nil)
        }catch let error{
            print(error.localizedDescription)
            completionHandler(nil,error)
        }
    }
    
    static func getDraftOrder(id: Int, completionHandler: @escaping (DraftOrderResponse?, Error?) -> Void) {
        do{
            let result = try JSONDecoder().decode(DraftOrderResponse.self, from: MockOrderResponse.draftOrder.data(using: .utf8)!)
            completionHandler(result,nil)
        }catch let error{
            print(error.localizedDescription)
            completionHandler(nil,error)
        }
    }
    
    static func postOrder(url: String, order: PostOrder, completionHandler: @escaping (ResponseOrder?, Error?) -> Void) {
        do{
            let result = try JSONDecoder().decode(ResponseOrder.self, from: MockOrderResponse.postOrder.data(using: .utf8)!)
            completionHandler(result,nil)
        }catch let error{
            print(error.localizedDescription)
            completionHandler(nil,error)
        }
    }
}
