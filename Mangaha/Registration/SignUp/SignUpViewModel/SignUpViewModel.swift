//
//  SignUpViewModel.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 07/06/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
class SignUpViewModel{
    var customer : ResponseCustomer = ResponseCustomer(id: 0, firstName: "")
    var bindedResult :  (()->()) = {}
    var cartId : Int = 0
    var email : String = ""
    var id : Int = 0
    var username : String = ""
    var db = Firestore.firestore()
    func postCustomer(myuserCustomer : userCustomer){
        NetworkServices.postCustomer(customer: myuserCustomer) { [weak self] customer, errors in
            guard let customer = customer else {return}
            self?.customer = customer
            print(customer.id)
            self?.email = myuserCustomer.customer.email
            self?.id = customer.id
            self?.username = myuserCustomer.customer.firstName
            self?.postCart()
        }
        DispatchQueue.main.async {
            self.bindedResult()
        }
    }
    func postCart(){
        NetworkServices.postDraftOrder(products: []) { draftResponse, error in
            self.cartId = draftResponse?.id ?? 0
            self.postFavorite(email: self.email , username: self.username, userId: self.id , cartId: self.cartId)
           
        }
    }
    func postFavorite(email : String , username : String , userId : Int,cartId:Int){
        NetworkServices.postDraftOrder(products: []) { draftResponse, error in
            let favoriteId = draftResponse?.id
            self.db.collection("users").addDocument(data: ["id" : userId , "email" : email , "username" : username , "FavoriteId" : favoriteId , "CartId" : self.cartId])
        }
    }
    func registerUser(customer : userCustomer){
        var email  = customer.customer.email
        var password = customer.customer.password
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error == nil{
                self.postCustomer(myuserCustomer: customer)
             
            }
            
            
        }
    }
}
