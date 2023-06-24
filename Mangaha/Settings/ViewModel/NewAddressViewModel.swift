//
//  NewAddressViewModel.swift
//  Mangaha
//
//  Created by ME on 12/06/2023.
//

import Foundation
class NewAddressViewModel{
    var bindedResult: (()->())={}
    var message = ""
    func generateCountries()->[String]{
        Locale.isoRegionCodes.map { (code) -> String in
            let identifier = Locale.identifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            return Locale(identifier: "en_US_POSIX").localizedString(forIdentifier: identifier) ?? "Unknown"
        }
    }
    
    
    func addNewAddress(address:AddressModel){
        NetworkServices.postNewAddress(address: address) {[weak self] newAddress, error in
            if let newAddress = newAddress{
                if Constant.getDefaultAddressId() == "none"{
                    print("check first address : \(Constant.isFirstAddress())")
                    Constant.saveDefaultAddressId(id: String(newAddress.id))
                    Constant.firstAddedAddress(isFirstAdrees: false)
                }
                self?.message = "New Address Added Succssefully"
                }else{
                    self?.message = error!.localizedDescription
                }
                DispatchQueue.main.async {
                    self?.bindedResult()
                }
            }
    }
    
}
