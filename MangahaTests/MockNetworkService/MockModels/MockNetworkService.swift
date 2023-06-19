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
    
    
}
