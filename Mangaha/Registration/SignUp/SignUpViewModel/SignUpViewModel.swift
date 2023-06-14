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
    var db = Firestore.firestore()
    func postCustomer(myuserCustomer : userCustomer){
        NetworkServices.postCustomer(customer: myuserCustomer) { [weak self] customer, errors in
            guard let customer = customer else {return}
            self?.customer = customer
            print(customer.id)
            let email = myuserCustomer.customer.email
            let id = customer.id
            let username = myuserCustomer.customer.firstName
            self?.db.collection("users").addDocument(data: ["id" : id , "email" : email , "username" : username])
            
        }
        DispatchQueue.main.async {
            self.bindedResult()
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
