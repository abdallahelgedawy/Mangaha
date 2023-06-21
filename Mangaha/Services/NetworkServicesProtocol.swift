//
//  NetworkServicesProtocol.swift
//  Mangaha
//
//  Created by mariam adly on 18/06/2023.
//

import Foundation
protocol NetworkServiceProtocol{
    static func getBrands(baseUrl: String,completionHandler: @escaping (Brands?) -> Void )
    
    static func getProducts(baseUrl: String,completionHandler: @escaping (Product?) -> Void )
    
    static func getAllAddressesForCustomer( compelitionHandler: @escaping ([CustomerAddress]?,Error?) -> Void)
    
    static func getOrders(url : String , completionHandler : @escaping (GetOrder? , Error?)->Void)
    
}
