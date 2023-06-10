//
//  LoginViewController.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 07/06/2023.
//

import UIKit


class LoginViewController: UIViewController {
   // let animationView = LottieAnimationView()
    override func viewDidLoad() {
        super.viewDidLoad()
      //  setupAnimation()
        loginBtn.layer.cornerRadius = 10
        
    }
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func myLoginBtn(_ sender: UIButton) {
  
    }
    
    @IBAction func noAccountBtn(_ sender: Any) {
        let signUpVc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
                navigationController?.pushViewController(signUpVc, animated: true)
    }
    /*   func setupAnimation(){
        animationView.animation = LottieAnimation.named("allsports")
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
  */

}
