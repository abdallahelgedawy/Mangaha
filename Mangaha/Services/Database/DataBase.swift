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
        savedProduct.isFavourite = product.isFavourite
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
        let predicate = NSPredicate(format: "isFavourite == %@ ", NSNumber(value: false))
        let request: NSFetchRequest<CartProduct> = CartProduct.fetchRequest()
        request.predicate = predicate
        do{
            return try context.fetch(request)
        }
        catch{
            print("error getting Data")
            return nil
        }
    }
    func getFavouriteProducts()->[CartProduct]?{
        let predicate = NSPredicate(format: "isFavourite == %@ ", NSNumber(value: true))
        let request: NSFetchRequest<CartProduct> = CartProduct.fetchRequest()
        request.predicate = predicate
        do{
            print("testing profile core data")
            return try context.fetch(request)
        }
        catch{
            print("error getting Data")
            return nil
        }
    }
    
    func fetchProductById(id:String , isFavourite:Bool = false)->[CartProduct]?{
        let request: NSFetchRequest<CartProduct> = CartProduct.fetchRequest()
        let idPredicate = NSPredicate(format: "isFavourite == %@ ", NSNumber(value: isFavourite))
        let favPredicate  = NSPredicate(format: "id MATCHES %@ ", id)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [idPredicate , favPredicate])
        request.predicate = compoundPredicate
        do{
          return try context.fetch(request)
            
        }catch{
           return nil
        }
    }
    
    func deleteProductFromDataBase(id:String,isFavourite:Bool){
        let products = fetchProductById(id: id , isFavourite: isFavourite)
        if let deletedProduct = products?[0]{
            context.delete(deletedProduct)
            save()
        }
    }
    
    func isProductInFavourite(id:String)->Bool{
        let  product = fetchProductById(id: id , isFavourite: true)
            return product?.count ?? 0 > 0
    }
    
    func isProductInCart(id:String)->Bool{
        let  product = fetchProductById(id: id)
            return product?.count ?? 0 > 0
    }
    
    func updateProductInCart(productId:String , count:String ){
        let updatedProduct = fetchProductById(id:productId)
        updatedProduct?.first?.quantity = count
        save()
        
    }
    
    func deleteEntity(){
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = CartProduct.fetchRequest()
        let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try context.execute(batchDelete)
            save()
        }catch{
            print("Error to delet entity")
        }
    }
    
    func deleteAllTableItems(completion:@escaping()->Void){
            let fetchRequest=NSFetchRequest<NSManagedObject>(entityName: "CartProduct")
            do {
                let products = try context.fetch(fetchRequest)
                print("hereeeeee")
                for product in products {
                    context.delete(product)
                    try context.save()
                    print("deletedSuccessfully")
                }
               
            } catch {
                print("eroor")
            }
        }
    func getFavouritesCount()->Int{
        return getFavouriteProducts()?.count ?? 0
    }
    func getCartCount()->Int{
        return getCartProducts()?.count ?? 0
    }
    
    func deleteCartProducts(){
        guard let cartProducts = getCartProducts()else{
            return
        }
        for p in cartProducts {
            context.delete(p)
            save()
        }
    }
    
}
