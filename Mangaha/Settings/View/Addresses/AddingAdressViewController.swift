//
//  AddingAdressViewController.swift
//  Mangaha
//
//  Created by ME on 08/06/2023.
//

import UIKit
import CoreLocation
class AddingAdressViewController: UIViewController {
    let customOrange = UIColor(hex: 0xFF7466)
   let locationManger = CLLocationManager()
    @IBOutlet var phoneTF: UITextField!
    @IBOutlet var warningLabel: UILabel!
    @IBOutlet var streetTF: UITextField!
    @IBOutlet var cityTF: UITextField!
    let newAdressVM = NewAddressViewModel()
    @IBOutlet var countryTF: DropDown!{
        didSet{
            self.countryTF.optionArray = newAdressVM.generateCountries()
            self.countryTF.selectedRowColor = customOrange
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.isHidden = true
        setupNavigationBar()
    }

    @IBAction func GPSpressed(_ sender: UIButton) {
        locationManger.requestWhenInUseAuthorization()
        setupLocationRequests()
        locationManger.requestLocation()
    }
    func setupNavigationBar(){
        navigationItem.setHidesBackButton(true, animated: true)
        let doneBarBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneNewAdress))
        doneBarBtn.tintColor = customOrange
        navigationItem.rightBarButtonItem = doneBarBtn
        let backBarBtn = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward.fill"), style: .plain, target: self, action: #selector(backToAdressesList))
        backBarBtn.tintColor = customOrange
        navigationItem.leftBarButtonItem = backBarBtn
        let apperance = UINavigationBarAppearance()
        apperance.configureWithTransparentBackground()
        apperance.backgroundColor = .white
        apperance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.standardAppearance = apperance
        navigationItem.scrollEdgeAppearance = apperance
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Add New Address"
    }
    @objc func doneNewAdress(){
        if countryTF.text?.count == 0 || cityTF.text?.count == 0 || streetTF.text?.count == 0 || phoneTF.text?.count == 0{
            warningLabel.text = "Pleasw fill all fields"
            warningLabel.isHidden = false
        }else{
            if phoneTF.text?.count ?? 0 < 11 || phoneTF.text?.count ?? 0 > 15 {
                warningLabel.text = "Invalid phone phone number"
                warningLabel.isHidden = false
                
            }else{
                newAdressVM.bindedResult={
                    self.view.makeToast(self.newAdressVM.message)
                }
                let address = Address(address1: streetTF.text ?? "", city: cityTF.text ?? "", phone: phoneTF.text ?? "", countryName: countryTF.text ?? "",country: countryTF.text ?? "")
                print(countryTF.text)
                newAdressVM.addNewAddress(address:AddressModel(address: address))
                countryTF.text = ""
                cityTF.text = ""
                streetTF.text = ""
                phoneTF.text = ""
                warningLabel.isHidden = true
            }
        }
    }
    @objc func backToAdressesList(){
        navigationController?.popViewController(animated: true)
    }
    
    
}
extension AddingAdressViewController:CLLocationManagerDelegate{
    
    func setupLocationRequests(){
         locationManger.delegate = self
            locationManger.desiredAccuracy = kCLLocationAccuracyBest
            //locationManger.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else{return}
        let geocoder = CLGeocoder()
                geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
                    if let error = error {
                        print("Reverse geocoding failed with error: \(error.localizedDescription)")
                        return
                    }
                    guard let placemark = placemarks?.first else { return }
                    
                    if let c = placemark.country{
                        self.countryTF.text = c
                    }
                    if let city = placemark.locality{
                        self.cityTF.text = city
                    }
                    if let street = placemark.subLocality{
                        self.streetTF.text = street
                    }
                   // self.loadin.isHidden = true
                  
                }
            }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
