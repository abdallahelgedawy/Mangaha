//
//  LoginViewController.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 07/06/2023.
//

import UIKit
import FirebaseAuth
import Lottie
import FirebaseFirestore


class LoginViewController: UIViewController {
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    var email : String? = nil
    var username : String? = nil
    var db = Firestore.firestore()
    var id : Int? = nil
    var loginViewModel = LoginViewModel()
    let animationView = LottieAnimationView()
    @IBOutlet weak var emailTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        loginBtn.layer.cornerRadius = 10
       
    }
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func myLoginBtn(_ sender: UIButton) {
        guard let email = emailTF.text else {return}
        guard let password = passwordTF.text else {return}
        Auth.auth().signIn(withEmail: email, password: password){ authresult , error in
            if let error = error{
                let alertController = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                }
               
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            }else{
                self.loginViewModel.retrieveUserData(email: email)
                self.navigationController?.pushViewController(TabBar(), animated: true)
            }
            
            
        }
    }
    
    @IBAction func noAccountBtn(_ sender: Any) {
        let signUpVc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        navigationController?.pushViewController(signUpVc, animated: true)
    }
    func setupAnimation(){
        animationView.animation = LottieAnimation.named("signin")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        myView.addSubview(animationView)
        // Center the animation view horizontally
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        /*
        // Center the animation view vertically
        NSLayoutConstraint.activate([
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        */
        
    }
}
