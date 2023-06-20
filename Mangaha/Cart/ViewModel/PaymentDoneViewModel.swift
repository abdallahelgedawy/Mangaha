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
}
