//
//  CartViewModel.swift
//  Mangaha
//
//  Created by ME on 15/06/2023.
//

import Foundation
class CartViewModel{
    var cartProducts = [CartProduct]()
    let dataBase = DataBase()
    
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
    
    func deleteFromCart(_ productId:String, _ index:Int){
        dataBase.deleteProductFromCart(id: productId)
        cartProducts.remove(at: index)
        
    }
}
