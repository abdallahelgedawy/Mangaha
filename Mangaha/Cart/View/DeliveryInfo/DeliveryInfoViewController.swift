//
//  DeliveryInfoViewController.swift
//  Mangaha
//
//  Created by ME on 08/06/2023.
//

import UIKit
import CoreLocation

class DeliveryInfoViewController: UIViewController {
    let customOrange = UIColor(hex: 0xFF7466)
    let deliveryVM = DeliveryViewModel()
    @IBOutlet var loadin: UIActivityIndicatorView!
    @IBOutlet var paymentBtn: UIButton!
    @IBOutlet var phoneNumberTf: UITextField!
    @IBOutlet var streetTf: UITextField!
    @IBOutlet var cityTf: UITextField!
    let locationManger = CLLocationManager()
    var country = ""
    var city = ""
    var street = ""
    @IBOutlet var countryTF: DropDown!{
        didSet{
            self.countryTF.optionArray = deliveryVM.generateCountries()
            self.countryTF.selectedRowColor = customOrange
        }
    }
    @IBOutlet var warningLabel: UILabel!
    @IBOutlet var defaultAddressBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        paymentBtn.layer.cornerRadius = 20
        loadin.isHidden = true
        warningLabel.isHidden = true
       
    }
    override func viewWillAppear(_ animated: Bool) {
        if Constant.getDefaultAddressId() == ""{
            defaultAddressBtn.isHidden = true
        }
        warningLabel.text = "Please fill all fields"
    }

    @IBAction func paymentPresses(_ sender: UIButton) {
        if countryTF.text?.count == 0 || cityTf.text?.count == 0 || streetTf.text?.count == 0 || phoneNumberTf.text?.count == 0{
            warningLabel.text = "Please fill all fields"
            warningLabel.isHidden = false
        }else{
            if phoneNumberTf.text?.count ?? 0 < 11 || phoneNumberTf.text?.count ?? 0 > 15 {
                warningLabel.isHidden = false
                warningLabel.text = "Invalid Phone Number"
            }else{
                let paymentVC = PaymentViewController(nibName: "PaymentViewController", bundle: nil)
                let address = CustomerAddress(id: 0, customerID: 0, firstName:"", address1: streetTf?.text ?? "", city: cityTf.text ?? "", phone: phoneNumberTf?.text ?? "", name: "", countryName: countryTF?.text ?? "", country: countryTF?.text ?? "", customerAddressDefault: false)
                deliveryVM.defaultAddress = address
                paymentVC.paymentVM = deliveryVM.inistintiatePaymentViewModel()
                navigationController?.pushViewController(paymentVC, animated: true)
            }
        }
    }
    @IBAction func chooseAdress(_ sender: UIButton) {
        loadin.isHidden = false
        setAddress(isDefault: true)
    }
    
    @IBAction func setAddressByGPS(_ sender: UIButton) {
        locationManger.requestWhenInUseAuthorization()
        setupLocationRequests()
        locationManger.requestLocation()
        countryTF.text = country
        cityTf.text = city
        streetTf.text = street
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
    
    func setAddress(isDefault:Bool){
        deliveryVM.bindedResult = {
            self.cityTf.text = self.deliveryVM.getCity()
            self.countryTF.text = self.deliveryVM.getCountry()
            self.streetTf.text = self.deliveryVM.gerStreet()
            if isDefault{
                self.phoneNumberTf.text = self.deliveryVM.getphone()
            }
            self.loadin.isHidden = true
        }
        deliveryVM.getDeafultAddress()
    }
}

extension DeliveryInfoViewController:CLLocationManagerDelegate{
    
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
                        self.cityTf.text = city
                    }
                    if let street = placemark.subThoroughfare{
                        self.streetTf.text = street
                    }
                    
                  
                }
            }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


