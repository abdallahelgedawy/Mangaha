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
    
    static func makeDeafultAddresses(adressId:String,compelitionHandler:@escaping (CustomerAddress?,Error?) -> Void)
    
    static func getAddressDetails(compelitionHandler:@escaping (CustomerAddress?,Error?) -> Void)
    
    static func postNewAddress(address:AddressModel,compelitionHandler: @escaping (CustomerAddress?,Error?) -> Void)
    
    static func getProductInfo( baseUrl : String , completionHandler : @escaping (myProduct?)->Void)
    
    static func postCustomer(customer : userCustomer , completionHandler : @escaping (ResponseCustomer? , Error?)->Void)
    
    static func postDraftOrder(products:[LineItems],completionHandler : @escaping (DraftOrderResponse? , Error?)->Void)
    
    static func getDraftOrder(id :Int , completionHandler:@escaping (DraftOrderResponse? , Error?)->Void)
    
    static func postOrder( url : String , order : PostOrder, completionHandler : @escaping ( ResponseOrder?, Error?)->Void)
  
}
