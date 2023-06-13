//
//  SignUpViewController.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 07/06/2023.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
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
                let alertController = UIAlertController(title: "Alert", message: "Registration Sucessfully", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                    let loginVc = LoginViewController(nibName: "LoginViewController", bundle: nil)
                    self.navigationController?.pushViewController(loginVc, animated: true)
                }
                
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            
              
            }
        }
    }
    

}
