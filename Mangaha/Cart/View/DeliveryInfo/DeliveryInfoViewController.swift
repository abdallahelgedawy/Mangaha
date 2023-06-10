//
//  DeliveryInfoViewController.swift
//  Mangaha
//
//  Created by ME on 08/06/2023.
//

import UIKit

class DeliveryInfoViewController: UIViewController {

    @IBOutlet var paymentBtn: UIButton!
    @IBOutlet var phoneNumberTf: UITextField!
    @IBOutlet var streetTf: UITextField!
    @IBOutlet var cityTf: UITextField!
    @IBOutlet var countryTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        paymentBtn.layer.cornerRadius = 20
        
    }

    @IBAction func paymentPresses(_ sender: UIButton) {
        let paymentVC = PaymentViewController(nibName: "PaymentViewController", bundle: nil)
        navigationController?.pushViewController(paymentVC, animated: true)
    }
    @IBAction func chooseAdress(_ sender: UIButton) {
    }
    
    func setupNavigationController(){
        navigationItem.setHidesBackButton(true, animated: true)
        let backBarBtn = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward.fill"), style: .plain, target: self, action: #selector(popView))
        backBarBtn.tintColor = .white
        navigationItem.leftBarButtonItem = backBarBtn
       
        let apperance = UINavigationBarAppearance()
        apperance.configureWithTransparentBackground()
        apperance.backgroundColor = UIColor(red: 255/256, green: 116/256, blue: 102/256, alpha: 1)
        apperance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = apperance
        navigationItem.scrollEdgeAppearance = apperance
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Delivery Info"
    }
    
    @objc func popView(){
        navigationController?.popViewController(animated: true)
    }

}
