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
    
    func updateProduct(id:String , count:String){
        print("product id"+id)
        dataBase.updateProductInCart(productId: id, count: count)
    }
    
    func getCartSubTotal()->String{
        var subTotal = 0.0
        for product in cartProducts {
            print("price" + (product.price ?? "00") )
            subTotal += (Double(product.price ?? "0.0") ?? 0.0) * (Double(product.quantity ?? "0.0") ?? 0.0) 
        }
        
        return Constant.isEuroCurrency() ? String(subTotal) + "    EUR" : String(subTotal) + "    EGP"
    }
}
