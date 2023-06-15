//
//  PaymentViewController.swift
//  Mangaha
//
//  Created by ME on 08/06/2023.
//

import UIKit

class PaymentViewController: UIViewController {

    
    @IBOutlet var paymentView: UIView!
    @IBOutlet var confirmBtn: UIButton!
    @IBOutlet var totalPaymentLabel: UILabel!
    @IBOutlet var discountLabel: UILabel!
    @IBOutlet var copounsTF: UITextField!
    @IBOutlet var deliveryFeesLabel: UILabel!
    @IBOutlet var subTotalLabel: UILabel!
    @IBOutlet var CashBtn: UIButton!
    @IBOutlet var applePaymentBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmBtn.layer.cornerRadius = 20
        paymentView.layer.borderWidth = 2
        paymentView.layer.borderColor = UIColor(red: 255/256, green: 116/256, blue: 102/256, alpha: 1).cgColor
        paymentView.layer.cornerRadius = 20
        setupNavigationController()
        
    }

    @IBAction func cashCheck(_ sender: UIButton) {
        CashBtn.backgroundColor = UIColor(red: 255/256, green: 116/256, blue: 102/256, alpha: 1)
        applePaymentBtn.backgroundColor = UIColor.lightGray
    }
    @IBAction func applePaymentCheck(_ sender: UIButton) {
        applePaymentBtn.backgroundColor = UIColor(red: 255/256, green: 116/256, blue: 102/256, alpha: 1)
        CashBtn.backgroundColor = UIColor.lightGray
    }
    @IBAction func confirmPayment(_ sender: UIButton) {
    }
    
    @IBAction func applyCopoun(_ sender: UIButton) {
    }
    func setupNavigationController(){
        let customOrange = UIColor(hex: 0xFF7466)
        navigationItem.setHidesBackButton(true, animated: true)
        let backBarBtn = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward.fill"), style: .plain, target: self, action: #selector(popView))
        backBarBtn.tintColor = customOrange
        navigationItem.leftBarButtonItem = backBarBtn
       
        let apperance = UINavigationBarAppearance()
        apperance.configureWithTransparentBackground()
        apperance.backgroundColor = .white
        apperance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.standardAppearance = apperance
        navigationItem.scrollEdgeAppearance = apperance
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Delivery Info"
    }
    @objc func popView(){
        navigationController?.popViewController(animated: true)
    }
    
    
}
