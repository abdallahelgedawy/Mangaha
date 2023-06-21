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
            let result = try JSONDecoder().decode([CustomerAddress].self, from: MockCustomerAdressResponse.customerAdressResponse.data(using: .utf8)!)
            compelitionHandler(result, nil)
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
    
}
