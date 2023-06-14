//
//  AddressesListViewModel.swift
//  Mangaha
//
//  Created by ME on 13/06/2023.
//

import Foundation
class AddressesListViewModel{
    var bindedResult: (()->())={}
    var defaultAddresssBindedResult: (()->())={}
    var deleteAddresssBindedResult: (()->())={}
    var deletingAddressMessage = ""
    var defaultAddressMessage = ""
    
    var addresses = [CustomerAddress]()
    
    func getCustomerAllAdresses(){
        NetworkServices.getAllAddressesForCustomer {[weak self] customerAddressses, error in
            if let customerAddressses = customerAddressses{
                self?.addresses = customerAddressses
            }
            DispatchQueue.main.async {
                self?.bindedResult()
            }
            
        }
    }
    
    func getAddressesCount()->Int{
        return addresses.count
    }
    
    func setDefaultAddress(index:Int){
        let addressId = addresses[index].id
        NetworkServices.makeDeafultAddresses(adressId: String(addressId)) {[weak self] address, error in
            if let address = address{
                let defaultAddressId = address.id
                Constant.saveDefaultAddressId(id: String(defaultAddressId))
                self?.defaultAddressMessage = "Address set as default successfully"
            }else{
                self?.defaultAddressMessage = "Failed to set as default address"
            }
            DispatchQueue.main.async {
                self?.defaultAddresssBindedResult()
            }
        }
    }
    
    func deleteAddress(index:Int){
        let addressId = addresses[index].id
        NetworkServices.deleteAddress(addressId: String(addressId)) {[weak self] message, error in
            if let message = message{
                self?.deletingAddressMessage = message
                self?.addresses.remove(at: index)
            }else{
                self?.deletingAddressMessage = error?.localizedDescription ?? "Can not delete this Address"
            }
            DispatchQueue.main.async {
                self?.deleteAddresssBindedResult()
            }
            
        }
    }
    
    func getAddressAtIndex(index:Int)->CustomerAddress{
        return addresses[index]
    }
}
