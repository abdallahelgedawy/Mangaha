//
//  Constant.swift
//  Mangaha
//
//  Created by mariam adly on 10/06/2023.
//

import Foundation
class Constant{
    private static var baseUrl = "https://0f0340065b43e0803729efbf5c2e1ff6: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@mad43-alex-ios3.myshopify.com/admin/api/2023-04/"


    static func allBrands() -> String{
        return baseUrl + "smart_collections.json"
    }
    static func productInfo(productId : Int)->String{
        return baseUrl + "products/\(productId).json"
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
    static func mainCategory(category_ID: Int,filterType:String) -> String {
         return baseUrl + "/products.json?collection_id=\(category_ID)&product_type=\(filterType)"
     }
    static func currencyConverterUrl(_ to:String , _ from:String , _ amount:String)->String{
       return  "https://api.apilayer.com/currency_data/convert?to=\(to)&from=\(from)&amount=\(amount)&apikey=CoqzinPSdBk5TsKscSDt66xd6K4cOZIB"
    }
    
    static let currencyKey = "Currency"
    static func postCustomerEndPoint()->String{
        return baseUrl + "customers.json"
    }
    
        
        static func isEuroCurrency()->Bool{
               return  UserDefaults.standard.object(forKey: Constant.currencyKey) as? String == "Eur"

        }
    static let currentUserName = "CurrentUserName"
    static let currentUserId = "CurrentUserId"
    private static let postBaeUrl = "https://mad43-alex-ios3.myshopify.com/admin/api/2023-04/"
    static func postDraftOrderEndPoint()->String{
        return postBaeUrl + "draft_orders.json"
    }
}
