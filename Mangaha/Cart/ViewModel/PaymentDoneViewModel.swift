//
//  PaymentDoneViewModel.swift
//  Mangaha
//
//  Created by ME on 20/06/2023.
//

import Foundation
class PaymentDoneViewModel{
    var cartProducts = [CartProduct]()
    let dataBase = DataBase()
    var address : CustomerAddress?
    
    func getCartProducts(){
        if let products = dataBase.getCartProducts(){
            cartProducts = products
        }
      
    }
    
    func getProductsCount()->Int{
        return cartProducts.count
    }
    
    func getProductAtIndex(index:Int)->CartProduct{
        return cartProducts[index]
    }
    
    func getCountry()->String{
        return address?.country ?? ""
    }
    func getCity()->String{
        return address?.city ?? ""
    }
    func getStreet()->String{
        return address?.address1 ?? ""
    }
    func getPhone()->String{
        return address?.phone ?? ""
    }
    func deleteCart(){
        dataBase.deleteCartProducts()
    }
}
