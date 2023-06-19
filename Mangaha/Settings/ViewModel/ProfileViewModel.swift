//
//  ProfileViewModel.swift
//  Mangaha
//
//  Created by ME on 17/06/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
class ProfileViewModel{
    let dataBase = DataBase()
    var favourites = [CartProduct]()
    let db = Firestore.firestore()
    var bindedResult: (()->())={}
    
    var bindOrderListToMEVC : (()->()) = {}
    var ordersList : [Order]? {
        didSet {
            bindOrderListToMEVC()
        }
    }

    func getOrderss(baseUrl:String){
        NetworkServices.getOrders(url: baseUrl){
            [weak self] result,error  in
            self?.ordersList = result?.orders
        }
    }
    
    func getOrdersAtIndex(index:Int)-> Order{
        return ordersList?[index] ?? Order()
    }
    
    func  getOrderssCount()->Int{
        return ordersList?.count ?? 0
    }
   private  func convertCoreDataToProduct(coreDataProducts:[CartProduct])->[LineItems]{
        var lineItems = [LineItems]()
        for product in coreDataProducts{
            let lineItem = LineItems(title: (product.title ?? "")+"?"+(product.id ?? "") , price: product.price ,quantity: Int(product.quantity ?? "1") , imageUrl: product.imageUrl)
            lineItems.append(lineItem)
        }
        return lineItems
    }
    
    private func getFavouritesItems()->[LineItems]{
        let favourites = dataBase.getFavouriteProducts() ?? [CartProduct]()
        return convertCoreDataToProduct(coreDataProducts: favourites)
    }
  private  func getCartItems()->[LineItems]{
        let cartItems = dataBase.getCartProducts() ?? [CartProduct]()
        return convertCoreDataToProduct(coreDataProducts: cartItems)
    }
    
     func makeFavouritesDraftOrder(){
        let lineItems = getFavouritesItems()
         print("before post\(lineItems)")
        NetworkServices.postDraftOrder(products: lineItems) { favouriteOrder, error in
            let favId = favouriteOrder?.id
            self.makeCartDraftOrder(favId ?? -1)
            let currentFavId = UserDefaults.standard.object(forKey: "FavoriteId") as? Int ?? -1
            let currentCartId = UserDefaults.standard.object(forKey: "CartId") as? Int ?? -1
            print("before logout \(currentFavId)")
            if currentFavId != -1 {
                self.deleteDraftOrder(currentFavId)
            }
            if currentCartId != -1 {
                
                self.deleteDraftOrder(currentCartId)
            }
            
            self.dataBase.deleteAllTableItems {
               
            }
            do{
                print("logout")
                try  Auth.auth().signOut()
            } catch{
                print("error logout")
            }
        }
    }
    
    private func deleteDraftOrder(_ id:Int){
        NetworkServices.deleteDraftOrder(id: id)
    }
    
    private  func makeCartDraftOrder(_ id:Int){
        let lineItems = getCartItems()
        NetworkServices.postDraftOrder(products: lineItems) { cartOrder, error in
            let cartId = cartOrder?.id
            self.updateFireBase(cartId ?? -1, id)
            
            DispatchQueue.main.async {
                self.bindedResult()
            }
        }
    }
    
   private  func updateFireBase(_ cartID:Int , _ favId:Int){
        let userEmail = Constant.getCurrentUserEmail()
        db.collection("users").whereField("email", isEqualTo: userEmail).getDocuments(completion: { email, error in
            if let error = error {
                print("Error fetching customer data: \(error.localizedDescription)")
                return
            }
            
            guard let documents = email?.documents else {
                print("No documents found")
                return
            }
            let updateData = ["FavoriteId":favId , "CartId": cartID]
            for doc in documents{
                doc.reference.setData(updateData, merge: true)
                self.updateUserData(cartID, favId: favId)
            }
            
            
        })
    }
    
    private func updateUserData(_ cartId:Int , favId:Int){
        UserDefaults.standard.set(cartId, forKey: "CartId")
        UserDefaults.standard.set(favId, forKey: "FavoriteId")
    }
    
    
    func getWishList(){
        if let favourites =  dataBase.getFavouriteProducts(){
            print(" me data")
            self.favourites = favourites
        }
        
    }
    func getFavouritesCount()->Int{
        return favourites.count
    }
    
    func getFavByIndex(_ index:Int)->CartProduct{
        return favourites[index]
    }
    
    func inistintiateProductDetVM(_ index : Int)->ProductDetailsViewModel{
        var productDetVM = ProductDetailsViewModel()
        productDetVM.productId = Int(favourites[index].id ?? "")
        return productDetVM
    }
}
                                                                                      
                                                                                
