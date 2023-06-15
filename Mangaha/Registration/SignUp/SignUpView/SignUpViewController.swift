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
    @IBOutlet weak var confirmationPasswordTF: UITextField!
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
        guard let username = usernameTF.text else {return}
        guard let confirmPassword = confirmationPasswordTF.text else {return}
        let lengthRequirement = password.count >= 8
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[\\p{P}\\p{S}])[A-Za-z\\d\\p{P}\\p{S}]+$"
        let formatRequirement = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
        if lengthRequirement && formatRequirement {
            if(password == confirmPassword){
                var customer = userCustomer(customer: Customer(firstName: username, email: email, verifiedEmail: true, password: password, passwordConfirmation: password, sendEmailWelcome: true))
                signUpViewModel.registerUser(customer: customer)
                let loginVc = LoginViewController(nibName: "LoginViewController", bundle: nil)
                self.navigationController?.pushViewController(loginVc, animated: true)
                
            }else{
                print("Not matching Password")
            }
        }else{
            print("Weak Password")
        }
            
    }
            
              
}
        

    
    


