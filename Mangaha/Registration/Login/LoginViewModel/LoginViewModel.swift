//
//  LoginViewModel.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 07/06/2023.
//

import Foundation
import FirebaseFirestore
class LoginViewModel{
    var db = Firestore.firestore()
    func retrieveUserData(email : String){
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
                // Process the customer data
                let firstName = data["username"] as? String ?? ""
                let id = data["id"] as? Int ?? 0
                print("before",firstName)
                print("before",id)
                self.saveDataIntoUserDefaults(username: firstName, id: id)
                
            }
        })
            
    }
    func saveDataIntoUserDefaults(username : String , id : Int){
        UserDefaults.standard.set(username, forKey: "CurrentUserName")
        UserDefaults.standard.set(id, forKey: "CurrentUserId")
    }
}
