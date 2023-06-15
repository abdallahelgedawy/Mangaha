//
//  SettingsViewModel.swift
//  Mangaha
//
//  Created by ME on 12/06/2023.
//

import Foundation
class SettingsViwewModel{
    let defaults = UserDefaults.standard
    
    func addCurrencyToDefaults(currency:String){
        defaults.set(currency, forKey: Constant.currencyKey)
    }
    
    func getCurrencyFromDefaults()->String{
        if let currency = defaults.object(forKey: Constant.currencyKey) as?String{
            return currency
        }
        return "Eur"
    }
}
