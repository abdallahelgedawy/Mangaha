//
//  ContactViewController.swift
//  Mangaha
//
//  Created by ME on 07/06/2023.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet var contactUsView: UIView!
    @IBOutlet var curencyView: UIView!
    @IBOutlet var adressView: UIView!
    @IBOutlet var curencyLabel: UILabel!
    @IBOutlet var countryNameLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var streetAdressLabel: UILabel!
    let settingsVM = SettingsViwewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewsCorners()
        setupNavigationBar()
        curencyLabel.text = getUserCurrency()
    }


    
    @objc func BackToMe(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeCurrency(_ sender: UIButton) {
        showChooseCurrencyAlert()
    }
    @IBAction func viewMoreAdresses(_ sender: UIButton) {
       let AdressesVC = AdressesListViewController(nibName: "AdressesListViewController", bundle: nil)
        navigationController?.pushViewController(AdressesVC, animated: true)
    }
    
    func setupNavigationBar(){
        let customOrange = UIColor(hex: 0xFF7466)
        navigationItem.setHidesBackButton(true, animated: true)
        let backBarBtn = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward.fill"), style: .plain, target: self, action: #selector(BackToMe))
        backBarBtn.tintColor = customOrange
        navigationItem.leftBarButtonItem = backBarBtn
        let apperance = UINavigationBarAppearance()
        apperance.configureWithTransparentBackground()
        apperance.backgroundColor = .white
        apperance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.standardAppearance = apperance
        navigationItem.scrollEdgeAppearance = apperance
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Contact Settings"
            
    }
    func setupViewsCorners(){
        contactUsView.changeCornerRadius(corner: [.topLeft,.topRight], radius: 20)
        adressView.changeCornerRadius(corner: [.topLeft,.bottomRight], radius: 30)
        curencyView.changeCornerRadius(corner: [.bottomLeft,.topRight], radius: 30)
    }
    func getUserCurrency()->String{
        return settingsVM.getCurrencyFromDefaults()
    }
    
    func showChooseCurrencyAlert(){
        let currencyAlert = UIAlertController(title: "Change Currency", message: "Choose your Currncy", preferredStyle: .alert)
        let egyAction = UIAlertAction(title: "EGP", style: .default){_ in
            self.curencyLabel.text = "EGP"
            self.settingsVM.addCurrencyToDefaults(currency: "EGP")

        }
        let dollarAction = UIAlertAction(title: "Eur", style: .default){_ in
            self.curencyLabel.text = "Eur"
            self.settingsVM.addCurrencyToDefaults(currency: "Eur")
        }
        currencyAlert.addAction(egyAction)
        currencyAlert.addAction(dollarAction)
        self.present(currencyAlert, animated: true)
    }
}
