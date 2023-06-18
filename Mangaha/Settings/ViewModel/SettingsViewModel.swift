//
//  SettingsViewModel.swift
//  Mangaha
//
//  Created by ME on 12/06/2023.
//

import Foundation
class SettingsViwewModel{
    let defaults = UserDefaults.standard
    var defaultAddress = [CustomerAddress]()
    var bindedResult: (()->())={}
    
    
    func addCurrencyToDefaults(currency:String){
        defaults.set(currency, forKey: Constant.currencyKey)
    }
    
    func getCurrencyFromDefaults()->String{
        if let currency = defaults.object(forKey: Constant.currencyKey) as?String{
            return currency
        }
        return "Eur"
    }
    
    func getDefaultAddress(){
        NetworkServices.getAddressDetails { [weak self] address, error in
            if let address = address{
                self?.defaultAddress.append(address)
                print("default" + (self?.defaultAddress.first?.address1 ?? "oooo" ))
            }
            DispatchQueue.main.async {
                self?.bindedResult()
            }
        }
    }
}
