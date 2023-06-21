//
//  PaymentViewController.swift
//  Mangaha
//
//  Created by ME on 08/06/2023.
//

import UIKit
import PassKit

class PaymentViewController: UIViewController {
    let customOrange = UIColor(hex: 0xFF7466)
    var paymentVM = PaymentViewModel()
    @IBOutlet var paymentView: UIView!
    @IBOutlet var confirmBtn: UIButton!
    @IBOutlet var totalPaymentLabel: UILabel!
    @IBOutlet var discountLabel: UILabel!
    @IBOutlet var copounsTF: DropDown!{
        didSet{
            paymentVM.setupCopouns()
            if paymentVM.getCopounsCount() == 0 {
                copounsTF.optionArray = ["NO COPUNS AVAILABLE"]
            }else{
                copounsTF.optionArray = paymentVM.getCoupouns()
            }
            self.copounsTF.selectedRowColor = customOrange
        }
    }
    @IBOutlet var deliveryFeesLabel: UILabel!
    @IBOutlet var subTotalLabel: UILabel!
    @IBOutlet var CashBtn: UIButton!
    @IBOutlet var applePaymentBtn: UIButton!
    var paymentMethod = false
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmBtn.layer.cornerRadius = 20
        paymentView.layer.borderWidth = 2
        paymentView.layer.borderColor = UIColor(red: 255/256, green: 116/256, blue: 102/256, alpha: 1).cgColor
        paymentView.layer.cornerRadius = 20
        setupNavigationController()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        applePaymentBtn.backgroundColor = .lightGray
        CashBtn.backgroundColor = .lightGray
        if Constant.isEuroCurrency(){
            subTotalLabel.text = paymentVM.getSubTotal() + "   EUR"
            deliveryFeesLabel.text = "5.0   EUR"
            totalPaymentLabel.text = paymentVM.getTotalPrice() + "   EUR"
        }else{
            subTotalLabel.text = paymentVM.getSubTotal() + "   EGP"
            deliveryFeesLabel.text = "35.0  EGP"
            totalPaymentLabel.text = paymentVM.getTotalPrice() + "   EGP"
        }
        
    }

    @IBAction func cashCheck(_ sender: UIButton) {
        if Constant.isEuroCurrency(){
            if Double(paymentVM.getTotalPrice()) ?? 0.0 > 1000{
                showPaymetCashErrorAlert(amount: "1000 EUR")
            }else{
                paymentMethod = true
                CashBtn.backgroundColor = UIColor(red: 255/256, green: 116/256, blue: 102/256, alpha: 1)
                applePaymentBtn.backgroundColor = UIColor.lightGray
            }
        }else{
            if Double(paymentVM.getTotalPrice()) ?? 0.0 > 15000 {
                showPaymetCashErrorAlert(amount: "15000  EGP")
            }else{
                paymentMethod = true
                CashBtn.backgroundColor = UIColor(red: 255/256, green: 116/256, blue: 102/256, alpha: 1)
                applePaymentBtn.backgroundColor = UIColor.lightGray
            }
        }
       
    }
    @IBAction func applePaymentCheck(_ sender: UIButton) {
        applePaymentBtn.backgroundColor = UIColor(red: 255/256, green: 116/256, blue: 102/256, alpha: 1)
        CashBtn.backgroundColor = UIColor.lightGray
        let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentVM.getPaymentRequest())
                if controller != nil {
                    controller!.delegate = self
                    present(controller!,  animated: true ,completion: nil)
                }
        paymentMethod = true
    }
    @IBAction func confirmPayment(_ sender: UIButton) {
        if paymentMethod == true{
            paymentVM.postOrder(url: Constant.postOrder())
            let donePaymentVC = PaymentDoneViewController(nibName: "PaymentDoneViewController", bundle: nil)
            donePaymentVC.paymentDoneVM = paymentVM.inistintiateDonePaymentViewModel()
            navigationController?.pushViewController(donePaymentVC, animated: true)
        }else{
            showChoosePaymentMethodAlert()
        }
    }
    
    @IBAction func applyCopoun(_ sender: UIButton) {
        var discount = 1.0
        if copounsTF.text == "MANGAHA10"{
            discount = 0.9
        }else if copounsTF.text == "MANGAHA20"{
            discount = 0.8
        }else if copounsTF.text == "MANGAHA30"{
            discount = 0.7
        }
        totalPaymentLabel.text = paymentVM.getTotalPrice(dicountPercent: discount)
        if Constant.isEuroCurrency(){
            discountLabel.text = paymentVM.caluculateDiscountAmount(discountPercent: discount) + "   EUR"
        }else{
            discountLabel.text = paymentVM.caluculateDiscountAmount(discountPercent: discount) + "   EGP"
        }
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
    
    func showPaymetCashErrorAlert(amount:String){
            let alert = UIAlertController(title: "Cash Payment unavailable", message: "Maximum amount for pay on cash is \( amount)", preferredStyle: .alert)
 
            let cancel = UIAlertAction(title: "OK", style: .cancel){_ in
               alert.dismiss(animated: true)
            }
           
            alert.addAction(cancel)
            self.present(alert, animated: true)
    }
    
    func showChoosePaymentMethodAlert(){
        let alert = UIAlertController(title: "No payment Method choosed", message: "Please choose payment method before confirm the order", preferredStyle: .alert)

        let cancel = UIAlertAction(title: "OK", style: .cancel){_ in
           alert.dismiss(animated: true)
        }
       
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
}
extension PaymentViewController : PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController , didAuthorizePayment payment: PKPayment , handler completion: @escaping (PKPaymentAuthorizationResult) -> Void){
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
}
