//
//  SignUpViewController.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 07/06/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class SignUpViewController: UIViewController {
    let db = Firestore.firestore()
    let signUpViewModel = SignUpViewModel()
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerBtn.layer.cornerRadius = 10
    }

    @IBOutlet weak var registerBtn: UIButton!
    
    @IBAction func signUpBtn(_ sender: UIButton) {
        guard let email = emailTF.text else{return}
        guard let password = passwordTF.text else{return}
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                let alertController = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                }
                
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            
            }else{
                let username = self.usernameTF.text ?? ""
               var customer = userCustomer(customer: Customer(firstName: username, email: email, verifiedEmail: true, password: password, passwordConfirmation: password, sendEmailWelcome: true))
                let customerId = self.signUpViewModel.customer.id
                let email = Auth.auth().currentUser?.email
                self.signUpViewModel.postCustomer(customer: customer)
                let alertController = UIAlertController(title: "Alert", message: "Registration Sucessfully", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                    let loginVc = LoginViewController(nibName: "LoginViewController", bundle: nil)
                    loginVc.username = username
                    loginVc.id = customerId
                    loginVc.email = email
                    self.navigationController?.pushViewController(loginVc, animated: true)
                    }
                    
                    
                    
                
                
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            
              
            }
        }
    }
    

}
