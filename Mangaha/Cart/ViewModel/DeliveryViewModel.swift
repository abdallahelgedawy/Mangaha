//
//  DeliveryViewModel.swift
//  Mangaha
//
//  Created by ME on 18/06/2023.
//

import Foundation
import CoreLocation
class DeliveryViewModel{
    var defaultAddress:CustomerAddress? = nil
    var bindedResult : (()->()) = {}
    func getDeafultAddress(){
        NetworkServices.getAddressDetails { address, error in
            if let address = address {
                self.defaultAddress = address
            }
            DispatchQueue.main.async {
                self.bindedResult()
            }
           
        }
    }
    
    func getCountry()->String{
        return defaultAddress?.country ?? ""
    }
    
    func getCity()->String{
        return defaultAddress?.city ?? ""
    }
    
    func gerStreet()->String{
        return defaultAddress?.address1 ?? ""
        
    }
    
    func getphone()->String{
        return defaultAddress?.phone ?? ""
    }
    func generateCountries()->[String]{
        Locale.isoRegionCodes.map { (code) -> String in
            let identifier = Locale.identifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            return Locale(identifier: "en_US_POSIX").localizedString(forIdentifier: identifier) ?? "Unknown"
        }
    }
}
