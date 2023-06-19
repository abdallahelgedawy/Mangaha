//
//  SignUpViewController.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 07/06/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class SignUpViewController: UIViewController , UITextFieldDelegate {
    @IBOutlet weak var matchLabel: UILabel!
    let db = Firestore.firestore()
    var isHide : Bool?
    let signUpViewModel = SignUpViewModel()
    @IBOutlet weak var confirmationPasswordTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerBtn.layer.cornerRadius = 10
        isHide = true
        passwordTF.delegate = self
        confirmationPasswordTF.delegate = self
        strengthLabel.text = "Weak password!"
            strengthLabel.textColor = .red
            
            matchLabel.text = "Doesn't Match!"
            matchLabel.textColor = .red
    }

    @IBOutlet weak var strengthLabel: UILabel!
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text,
                  let textRange = Range(range, in: currentText) else {
                return true
            }
            
            let updatedText = currentText.replacingCharacters(in: textRange, with: string)
            
            if textField == passwordTF {
                let passwordStrength = checkPasswordStrength(updatedText)
                
                switch passwordStrength {
                case "Weak":
                    strengthLabel.text = "Weak password!"
                    strengthLabel.textColor = .red
                case "Strong":
                    strengthLabel.text = "Strong password!"
                    strengthLabel.textColor = .green
                default:
                    strengthLabel.text = ""
                }
            } else if textField == confirmationPasswordTF {
                let passwordStrength = checkPasswordConfirmation(passwordTF.text ?? "", updatedText)
                
                switch passwordStrength {
                case "Doesn't Match":
                    matchLabel.text = "Doesn't Match!"
                    matchLabel.textColor = .red
                case "Match":
                    matchLabel.text = "Match!"
                    matchLabel.textColor = .green
                default:
                    matchLabel.text = ""
                }
            }
            
            return true
       }
    
    private func checkPasswordStrength(_ password: String) -> String {
        let lengthRequirement = password.count >= 8
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[\\p{P}\\p{S}])[A-Za-z\\d\\p{P}\\p{S}]+$"
        let formatRequirement = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
        if lengthRequirement && formatRequirement {
            return "Strong"
        }
        else {
            return "Weak"
        }
    }
    private func checkPasswordConfirmation(_ password: String , _ confirmPassword : String) -> String {
        if confirmPassword.isEmpty {
                return "Doesn't Match"
            } else if confirmPassword == password {
                return "Match"
            } else {
                return "Doesn't Match"
            }
      
    }
            
    @IBAction func alreadyHaveAccount(_ sender: UIButton) {
        let loginVc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        navigationController?.pushViewController(loginVc, animated: true)
    }
    
    @IBAction func toggleBtnSignUp(_ sender: UIButton) {
            isHide = !isHide!
            
            if isHide! {
                sender.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
                passwordTF.isSecureTextEntry = true
            } else {
                sender.setImage(UIImage(systemName: "eye.fill"), for: .normal)
                passwordTF.isSecureTextEntry = false
            }
       
    }
    
    @IBAction func toggleBtnConfirm(_ sender: Any) {
        isHide = !isHide!
        
        if isHide! {
            (sender as AnyObject).setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            confirmationPasswordTF.isSecureTextEntry = true
        } else {
            (sender as AnyObject).setImage(UIImage(systemName: "eye.fill"), for: .normal)
            confirmationPasswordTF.isSecureTextEntry = false
        }
    }
}
    

        

    
    


