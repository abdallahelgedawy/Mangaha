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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewsCorners()
        setupNavigationBar()
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
        navigationItem.setHidesBackButton(true, animated: true)
        let backBarBtn = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward.fill"), style: .plain, target: self, action: #selector(BackToMe))
        backBarBtn.tintColor = .white
        navigationItem.leftBarButtonItem = backBarBtn
        let apperance = UINavigationBarAppearance()
        apperance.configureWithTransparentBackground()
        apperance.backgroundColor = UIColor(red: 255/256, green: 116/256, blue: 102/256, alpha: 1)
        apperance.titleTextAttributes = [.foregroundColor: UIColor.white]
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
    
    func showChooseCurrencyAlert(){
        let currencyAlert = UIAlertController(title: "Change Currency", message: "Choose your Currncy", preferredStyle: .alert)
        let egyAction = UIAlertAction(title: "EGY", style: .default){_ in
            self.curencyLabel.text = "EGY"

        }
        let dollarAction = UIAlertAction(title: "Dollar", style: .default){_ in
            self.curencyLabel.text = "Dollar"
        }
        currencyAlert.addAction(egyAction)
        currencyAlert.addAction(dollarAction)
        self.present(currencyAlert, animated: true)
    }
}
