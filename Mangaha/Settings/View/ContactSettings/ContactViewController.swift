//
//  ContactViewController.swift
//  Mangaha
//
//  Created by ME on 07/06/2023.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet var loadingBar: UIActivityIndicatorView!
    @IBOutlet var addNewAddressBtn: UIButton!
    @IBOutlet var viewAddressBtn: UIButton!
    @IBOutlet var noAdressLabel: UILabel!
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
        loadingBar.isHidden = true
        noAdressLabel.isHidden = true
        addNewAddressBtn.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        curencyLabel.text = getUserCurrency()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
        setupDefaultAddressView()
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
    
    @IBAction func addNewAddress(_ sender: UIButton) {
        let addNewAddressVC = AddingAdressViewController(nibName: "AddingAdressViewController", bundle: nil)
        navigationController?.pushViewController(addNewAddressVC, animated: true)
    }
    
    func setupDefaultAddressView(){
        if Constant.isFirstAddress(){
            viewAddressBtn.isHidden = true
            noAdressLabel.isHidden = false
            addNewAddressBtn.isHidden = false
        }else{
            noAdressLabel.isHidden = true
            addNewAddressBtn.isHidden = true
            loadingBar.isHidden = false
            settingsVM.bindedResult={
                self.loadingBar.isHidden = true
                let defaultAddress = self.settingsVM.defaultAddress.first
                self.cityNameLabel.text = defaultAddress?.city
                self.countryNameLabel.text = defaultAddress?.countryName
                self.streetAdressLabel.text = defaultAddress?.address1
        
            }
            settingsVM.getDefaultAddress()
            
        }
        
        
    }
    
    
}
