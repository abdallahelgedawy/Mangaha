//
//  SignUpViewModel.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 07/06/2023.
//

import Foundation
class SignUpViewModel{
    var customer : ResponseCustomer = ResponseCustomer(id: 0, firstName: "")
    var bindedResult :  (()->()) = {}
    func postCustomer(customer : userCustomer){
        NetworkServices.postCustomer(customer: customer) { [weak self] customer, errors in
            guard let customer = customer else {return}
            self?.customer = customer
            print(customer.id)
        }
        DispatchQueue.main.async {
            self.bindedResult()
        }
    }
    
    
}
