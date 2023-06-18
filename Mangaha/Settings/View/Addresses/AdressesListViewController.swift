//
//  AdressesListViewController.swift
//  Mangaha
//
//  Created by ME on 08/06/2023.
//

import UIKit

class AdressesListViewController: UIViewController {

    @IBOutlet var loadingBar: UIActivityIndicatorView!
    let addressListVM = AddressesListViewModel()
    @IBOutlet var adressesTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        adressesTable.dataSource = self
        adressesTable.delegate = self
        registerCell()
        setupNavigationBar()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        setupAddressesList()
    }

    func registerCell(){
        adressesTable.register(UINib(nibName: "AdressesCell", bundle: nil), forCellReuseIdentifier: "AdressesCell")
    }
    
    func setupNavigationBar(){
        let customOrange = UIColor(hex: 0xFF7466)
        navigationItem.setHidesBackButton(true, animated: true)
        let addBarBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewAdress))
        addBarBtn.tintColor = customOrange
        navigationItem.rightBarButtonItem = addBarBtn
        let backBarBtn = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward.fill"), style: .plain, target: self, action: #selector(BackToSettings))
        backBarBtn.tintColor = customOrange
        navigationItem.leftBarButtonItem = backBarBtn
        let apperance = UINavigationBarAppearance()
        apperance.configureWithTransparentBackground()
        apperance.backgroundColor = .white
        apperance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.standardAppearance = apperance
        navigationItem.scrollEdgeAppearance = apperance
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Your Adresses"
    }
    @objc func BackToSettings(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    @objc func addNewAdress(){
        let addAdressVC = AddingAdressViewController(nibName: "AddingAdressViewController", bundle: nil)
        navigationController?.pushViewController(addAdressVC, animated: true)
    }
    
    func addressSettingAlert(_ index:Int){
        let addressSettingAlert = UIAlertController(title: "Address Settings", message: "Make this Address as your default address ?", preferredStyle: .alert)
        let setDefault = UIAlertAction(title: "Set as default", style: .default){_ in
            self.setDefaultAddress(index)
           
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel){_ in
            addressSettingAlert.dismiss(animated: true)
        }
        addressSettingAlert.addAction(setDefault)
        addressSettingAlert.addAction(cancel)
        self.present(addressSettingAlert, animated: true)
    }
    
    func setDefaultAddress(_ index:Int){
        addressListVM.defaultAddresssBindedResult={
            self.adressesTable.makeToast(self.addressListVM.defaultAddressMessage)
            self.adressesTable.reloadData()
        }
        addressListVM.setDefaultAddress(index: index)
    }
    
    func deleteAddress(_ index:Int){
        addressListVM.deleteAddresssBindedResult={
            self.view.makeToast(self.addressListVM.deletingAddressMessage)
            self.adressesTable.reloadData()
        }
        addressListVM.deleteAddress(index: index)
        
    }
    
    func deletingAddressAlert(_ index:Int){
        let deletingAddress = UIAlertController(title: "Delete Address", message: "Are you sure you want to delete this address ?", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Delete", style: .destructive){_ in
            self.deleteAddress(index)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel){_ in
            deletingAddress.dismiss(animated: true)
        }
        deletingAddress.addAction(confirm)
        deletingAddress.addAction(cancel)
        self.present(deletingAddress, animated: true)
    }
    
    func setupAddressesList(){
        addressListVM.bindedResult={
            self.loadingBar.isHidden = true
            self.adressesTable.reloadData()
        }
        addressListVM.getCustomerAllAdresses()
    }
  
}
extension AdressesListViewController  :UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressListVM.getAddressesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdressesCell", for: indexPath) as? AdressesCell
        cell?.cellBuble.changeCornerRadius(corner: [.topLeft , .bottomRight], radius: 20)
        let address = addressListVM.getAddressAtIndex(index: indexPath.row)
        cell?.cityLabel.text = address.city
        cell?.countryLabel.text = address.countryName
        cell?.streetLabel.text = address.address1
        cell?.phoneLabel.text = address.phone
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addressSettingAlert(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deletingAddressAlert(indexPath.row)
        }
    }
    
}
