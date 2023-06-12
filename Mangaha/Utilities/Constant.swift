//
//  Constant.swift
//  Mangaha
//
//  Created by mariam adly on 10/06/2023.
//

import Foundation
class Constant{
    private static var baseUrl = "https://d097bbce1fd2720f1d64ced55f0e485b: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@mad43-alex-ios-team4.myshopify.com/admin/api/2023-04/"


    static func allBrands() -> String{
        return baseUrl + "smart_collections.json"
    }
    
    static func produts(Brand_ID: Int) -> String{
        return baseUrl + "products.json?collection_id=\(Brand_ID)"
    }
    
    static func allProducts() -> String {
        return baseUrl + "products.json?"
    }
    
   static func mainCategory(category_ID: Int) -> String {
        return baseUrl + "/products.json?collection_id=\(category_ID)"
    }
    
}
