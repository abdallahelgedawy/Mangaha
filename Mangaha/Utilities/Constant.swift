//
//  Constant.swift
//  Mangaha
//
//  Created by mariam adly on 10/06/2023.
//

import Foundation
class Constant{
    private static var baseUrl = "https://0f0340065b43e0803729efbf5c2e1ff6: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@mad43-alex-ios3.myshopify.com/admin/api/2023-04/"
    private static var baseCategoryUrl = "https://d097bbce1fd2720f1d64ced55f0e485b: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@mad43-alex-ios-team4.myshopify.com/admin/api/2023-04/"

        private static let postBaseUrl = "https://mad43-alex-ios3.myshopify.com/admin/api/2023-04/"

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
        return baseCategoryUrl + "/products.json?collection_id=\(category_ID)"
    }
    static func mainCategory(category_ID: Int,filterType:String) -> String {
         return baseCategoryUrl + "/products.json?collection_id=\(category_ID)&product_type=\(filterType)"
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
    
    static func postAddressEndPoint()->String{
        return postBaseUrl + "customers/\(getCurrentCustomerId())/addresses.json"
    }
    
    static func getAllAddressesEndPoint()->String{
        return baseUrl + "customers/\(getCurrentCustomerId())/addresses.json"
    }
    
    static func defaultAddressEndPoint(addressId:String)->String{
        return postBaseUrl + "customers/\(getCurrentCustomerId())/addresses/\(addressId)/default.json"
    }
    
    static func getCurrentCustomerId()->String{
        let userId = UserDefaults.standard.object(forKey: "CurrentUserId") as? Int ?? 0
        return String(userId)
    }
    
    static func deleteAddressEndPoint(addressId:String)->String{
        return postBaseUrl + "customers/\(getCurrentCustomerId())/addresses/\(addressId).json"
    }
    
    static func firstAddedAddress(isFirstAdrees:Bool){
        UserDefaults.standard.set(isFirstAdrees, forKey: "firsAddress")
    }
    
    static func isFirstAddress()->Bool{
        return UserDefaults.standard.object(forKey: "firsAddress") as? Bool ?? true
    }
    static let defaultAdressIdKey = "DeafultAddressKey"
    
    static func saveDefaultAddressId(id:String){
        UserDefaults.standard.set(id, forKey: defaultAdressIdKey)
    }
    
    static func getDefaultAddressId()->String{
        return (UserDefaults.standard.object(forKey: defaultAdressIdKey) as? String ?? "")
    }
    
    static func getAddressDetailsEndPoint()->String{
        return baseUrl + "customers/\(getCurrentCustomerId())/addresses/\(getDefaultAddressId()).json"
    }
    

       
    static let currentUserName = "CurrentUserName"
    static let currentUserId = "CurrentUserId"

    static func postDraftOrderEndPoint()->String{
        return postBaseUrl + "draft_orders.json"
    }

    static func getCurrentUserEmail()->String{
        return UserDefaults.standard.object(forKey: "UserEmail") as? String ?? ""
    }
    static func DraftOrderEndPoint(id:Int)->String{
       return "https://0f0340065b43e0803729efbf5c2e1ff6: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@mad43-alex-ios3.myshopify.com/admin/api/2023-04/draft_orders/\(id).json"
    }
    static let MARCHANT_ID = "merchant.com.pushpendra.pay"
    
    static func postOrder()-> String{
        return baseUrl + "orders.json"
    }
    
    static func getOrder(customerId : Int)-> String{
        return baseUrl + "customers/\(customerId)/orders.json"
    }
}
    

