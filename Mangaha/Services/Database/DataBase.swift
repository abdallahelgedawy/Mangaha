//
//  DataBase.swift
//  Mangaha
//
//  Created by ME on 15/06/2023.
//

import Foundation
import CoreData
import UIKit

class DataBase{
    let  context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  init(){
     context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
  }
    
    func addToCart(product:CoreDataProduct){
        let savedProduct = CartProduct(context:context)
        savedProduct.id = product.id
        savedProduct.image = product.image
        savedProduct.imageUrl = product.imageUrl
        savedProduct.price = product.price
        savedProduct.quantity = product.quantity
        savedProduct.title = product.title
        save()
    }
    
    func save(){
        do{
            try context.save()
        }catch{
            print("error saving")
        }
    }
    
    func getCartProducts()->[CartProduct]?{
        let request: NSFetchRequest<CartProduct> = CartProduct.fetchRequest()
        do{
            return try context.fetch(request)
        }
        catch{
            print("error getting Data")
            return nil
        }
    }
    
    func fetchProductById(id:String)->[CartProduct]?{
        let request: NSFetchRequest<CartProduct> = CartProduct.fetchRequest()
        request.predicate  = NSPredicate(format: "id MATCHES %@ ", id)
        do{
          return try context.fetch(request)
            
        }catch{
           return nil
        }
    }
    
    func deleteProductFromCart(id:String){
        let products = fetchProductById(id: id)
        if let deletedProduct = products?[0]{
            context.delete(deletedProduct)
            save()
        }
    }
    
    func isProductInCart(id:String)->Bool{
        let  product = fetchProductById(id: id)
            return product?.count ?? 0 > 0
    }
    
}
