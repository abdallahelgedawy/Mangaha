//
//  PaymentDoneViewController.swift
//  Mangaha
//
//  Created by ME on 20/06/2023.
//

import UIKit

class PaymentDoneViewController: UIViewController {
    var paymentDoneVM = PaymentDoneViewModel()
    @IBOutlet var PhoneLabel: UILabel!
    @IBOutlet var streetLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var backHomeBtn: UIButton!
    @IBOutlet var deliveryInfoView: UIView!
    @IBOutlet var productTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        productTable.dataSource = self
        productTable.delegate = self
        RegisterCell()
        navigationItem.setHidesBackButton(true, animated: true)
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
            self.paymentDoneVM.deleteCart()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        paymentDoneVM.getCartProducts()
        setupDelivryInfo()
        backHomeBtn.layer.cornerRadius = 20
    }
    func RegisterCell(){
        productTable.register(UINib(nibName: "FinalOrderCell", bundle: nil), forCellReuseIdentifier: "FinalOrderCell")
    }

    func setupDelivryInfo(){
        deliveryInfoView.changeCornerRadius(corner: [.topLeft,.bottomRight], radius: 20)
        countryLabel.text = paymentDoneVM.getCountry()
        cityLabel.text = paymentDoneVM.getCity()
        streetLabel.text = paymentDoneVM.getStreet()
        PhoneLabel.text = paymentDoneVM.getPhone()
    }

    @IBAction func BackToHome(_ sender: UIButton) {
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        navigationController?.pushViewController(homeVC, animated: true)
    }
}

extension PaymentDoneViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentDoneVM.getProductsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FinalOrderCell", for: indexPath) as? FinalOrderCell
        let product = paymentDoneVM.getProductAtIndex(index: indexPath.row)
        cell?.productImg.image = UIImage(data: product.image ?? Data())
        cell?.productName.text = product.title
        cell?.productPrice.text = product.price
        cell?.productQuantity.text = product.quantity
        let totalPrice = (Double(product.price ?? "0.0") ?? 0.0) * (Double(product.quantity ?? "0.0") ?? 0.0)
        if Constant.isEuroCurrency(){
            cell?.productTotalPrice.text = String(format: "%.2f", totalPrice) + "  EUR"
            
        }else{
            cell?.productTotalPrice.text = String(format: "%.2f", totalPrice) + "  EGP"
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return productTable.frame.height * 0.5
    }
    
   
}
