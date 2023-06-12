//
//  LoginViewController.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 07/06/2023.
//

import UIKit
import FirebaseAuth
import Lottie


class LoginViewController: UIViewController {
    @IBOutlet weak var passwordTF: UITextField!
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
                let homeVc = HomeViewController(nibName: "HomeViewController", bundle: nil)
                self.navigationController?.pushViewController(homeVc, animated: true)
            }
            
            
        }
    }
    
    @IBAction func noAccountBtn(_ sender: Any) {
        let signUpVc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        navigationController?.pushViewController(signUpVc, animated: true)
    }
    func setupAnimation(){
        animationView.animation = LottieAnimation.named("signin")
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        // Center the animation view horizontally
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        // Center the animation view vertically
        NSLayoutConstraint.activate([
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        
    }
}
