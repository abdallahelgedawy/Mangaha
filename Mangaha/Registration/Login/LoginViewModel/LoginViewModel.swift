//
//  LoginViewModel.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 07/06/2023.
//

import Foundation
import FirebaseFirestore
import SDWebImage
class LoginViewModel{
    var db = Firestore.firestore()
   
    let dataBase = DataBase()
    let  context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func retrieveUserData(email : String , completion:@escaping()->Void){
        self.db.collection("users").whereField("email", isEqualTo: email).getDocuments(completion: { email, error in
            if let error = error {
                print("Error fetching customer data: \(error.localizedDescription)")
                return
            }
            
            guard let documents = email?.documents else {
                print("No documents found")
                return
            }
            for document in documents {
                let data = document.data()
                let firstName = data["username"] as? String ?? ""
                let id = data["id"] as? Int ?? 0
                let favoriteId = data["FavoriteId"] as? Int ?? -1
                let cartId = data["CartId"] as? Int ?? -1
                let userEmail = data["email"] as? String ?? ""
                print("before",firstName)
                print("before",id)
                print("before login \(favoriteId)")
                self.saveDataIntoUserDefaults(username: firstName, id: id , favoriteId: favoriteId , cartId: cartId ,email: userEmail)
                self.getDataFromServer()
                
            }
        })
            
    }
    func saveDataIntoUserDefaults(username : String , id : Int , favoriteId : Int , cartId : Int , email:String){
        UserDefaults.standard.set(username, forKey: "CurrentUserName")
        UserDefaults.standard.set(id, forKey: "CurrentUserId")
        UserDefaults.standard.set(favoriteId, forKey: "FavoriteId")
        UserDefaults.standard.set(cartId, forKey: "CartId")
        UserDefaults.standard.set(email, forKey: "UserEmail")
    }
    
    private func convertLineItemsToCoreDtaProduct(lineItems:[LineItems] ,isFavourite:Bool){
        for item in lineItems{
           let data =  item.title?.components(separatedBy: "?")
            let title = data?[0]
            let id = data?[1]
            var product = CartProduct(context: context)
            product.id = id
            product.imageUrl = item.imageUrl
            product.title = title
            product.price = item.price
            product.quantity = String(item.quantity ?? 1)
            var image : UIImageView?
            DispatchQueue.main.async {
                image = UIImageView()
                image?.sd_setImage(with: URL(string: item.imageUrl ?? ""))
                product.image = image?.image?.jpegData(compressionQuality: 1)
            }
            
            product.isFavourite = isFavourite
            print(" save product")
            dataBase.save()
        }
    }
    // 1119558861086
     func getDataFromServer(){
       getFavourites()
        getCartProducts()
    }
    
    private func getFavourites(){
        let favId = UserDefaults.standard.object(forKey: "FavoriteId") as? Int ?? -1
        print("favId: \(favId)")
        if favId != -1 {
            NetworkServices.getDraftOrder(id: favId) { favOrders, error in
                print("get fav products")
                self.convertLineItemsToCoreDtaProduct(lineItems: favOrders?.lineItems ?? [LineItems](), isFavourite: true)
            }
        }
    }
    
   private func getCartProducts(){
        let cartId = UserDefaults.standard.object(forKey: "CartId") as? Int ?? -1
       print("cartId: \(cartId)")
       if cartId != -1 {
           NetworkServices.getDraftOrder(id: cartId) { cartOrders, error in
               self.convertLineItemsToCoreDtaProduct(lineItems: cartOrders?.lineItems ?? [LineItems](), isFavourite: false)
              
           }
       }
    }
    
    
    
    
    
}
