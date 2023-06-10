//
//  AddingAdressViewController.swift
//  Mangaha
//
//  Created by ME on 08/06/2023.
//

import UIKit

class AddingAdressViewController: UIViewController {

    @IBOutlet var warningLabel: UILabel!
    @IBOutlet var streetTF: UITextField!
    @IBOutlet var cityTF: UITextField!
    @IBOutlet var countryTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.isHidden = true
        setupNavigationBar()
    }

    func setupNavigationBar(){
        navigationItem.setHidesBackButton(true, animated: true)
        let doneBarBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneNewAdress))
        doneBarBtn.tintColor = .white
        navigationItem.rightBarButtonItem = doneBarBtn
        let backBarBtn = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward.fill"), style: .plain, target: self, action: #selector(backToAdressesList))
        backBarBtn.tintColor = .white
        navigationItem.leftBarButtonItem = backBarBtn
        let apperance = UINavigationBarAppearance()
        apperance.configureWithTransparentBackground()
        apperance.backgroundColor = UIColor(red: 255/256, green: 116/256, blue: 102/256, alpha: 1)
        apperance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = apperance
        navigationItem.scrollEdgeAppearance = apperance
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Add New Address"
            
    }
    @objc func doneNewAdress(){
        if countryTF.text?.count == 0 || cityTF.text?.count == 0 || streetTF.text?.count == 0 {
            warningLabel.isHidden = false
        }else{
            countryTF.text = ""
            cityTF.text = ""
            streetTF.text = ""
            warningLabel.isHidden = true
        }
    }
    @objc func backToAdressesList(){
        navigationController?.popViewController(animated: true)
    }
}
