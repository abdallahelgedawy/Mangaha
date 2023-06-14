//
//  NetworkServices.swift
//  Mangaha
//
//  Created by mariam adly on 10/06/2023.
//

import Foundation

class NetworkServices{
    static func getBrands(baseUrl: String,completionHandler: @escaping (Brands?) -> Void ){
        let url = URL(string: baseUrl)
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(Brands.self, from: data!)
                completionHandler(result)
            }catch let error{
                print(error.localizedDescription)
                completionHandler(nil)
            }
        
        }
        task.resume()

    }

    static func getProducts(baseUrl: String,completionHandler: @escaping (Product?) -> Void ){
        let url = URL(string: baseUrl)
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(Product.self, from: data!)
                completionHandler(result)
            }catch let error{
                print(error.localizedDescription)
                completionHandler(nil)
            }
        
        }
        task.resume()

    }
    //convery Currency from Euro to Egp
   static func convertCurency(amount:String,completionHandler: @escaping (Double? ,Error?) -> Void ){
       let url = URL(string: Constant.currencyConverterUrl("EGP", "Eur", amount))
        guard let url = url else{
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(CurrencyConverter.self, from: data!)
                completionHandler(result.result,nil)
            }catch let error{
                print(error.localizedDescription)
                completionHandler(nil,error)
            }
        
        }
        task.resume()
    }
    
 // post a new adsress
    static func postNewAddress(address:AddressModel,compelitionHandler: @escaping (CustomerAddress?,Error?) -> Void){
        guard let url = URL(string: Constant.postAddressEndPoint())else{
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("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", forHTTPHeaderField: "X-Shopify-Access-Token")
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(address)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode addresses model:", error)
            return
        }

        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Request error:", error)
                return
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let responseModel = try decoder.decode(PostAdreesResponse.self, from: data)
                    let address = responseModel.customerAddress
                    compelitionHandler(address,nil)
                } catch {
                    print("error decoding addresses")
                    compelitionHandler(nil,error)
                    return
                }
            }
        }
        task.resume()
    }
    
    
    // get all addresses for Custumer
    
    static func getAllAddressesForCustomer( compelitionHandler: @escaping ([CustomerAddress]?,Error?) -> Void){
        guard let url = URL(string: Constant.getAllAddressesEndPoint())else{
        return
        }
        var request  = URLRequest(url: url)
        request.httpMethod =  "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            do {
                guard let data = data else{
                    return
                }
                let decoder = JSONDecoder()
                let result = try decoder.decode(GetAddressModel.self, from: data)
                let addresses = result.addresses
                print("all adreess : \(addresses?.count)")
                compelitionHandler(addresses,nil)
            } catch {
                print("all adresse error")
                compelitionHandler(nil, error)
            }
        }
        task.resume()
        
    }
    
    static func makeDeafultAddresses(adressId:String,compelitionHandler:@escaping (CustomerAddress?,Error?) -> Void){
        guard let url = URL(string: Constant.defaultAddressEndPoint(addressId: adressId))else{
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("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", forHTTPHeaderField: "X-Shopify-Access-Token")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            do {
                guard let data = data else{
                    return
                }
                let decoder = JSONDecoder()
                let addresses = try decoder.decode(PostAdreesResponse.self, from: data)
                compelitionHandler(addresses.customerAddress,nil)
            } catch {
                compelitionHandler(nil, error)
            }
        }
        task.resume()
    }
    
    // delete Address
    static func deleteAddress(addressId:String,compelitionHandler:@escaping (String?,Error?) -> Void){
        guard let url = URL(string: Constant.deleteAddressEndPoint(addressId: addressId))else{
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("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", forHTTPHeaderField: "X-Shopify-Access-Token")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                // Handle the error
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    compelitionHandler("Addresses Deleted Succefully",nil)
                } else {
                    compelitionHandler(nil,error)
                }
            }
        }

        task.resume()
    }
    
    static func getAddressDetails(compelitionHandler:@escaping (CustomerAddress?,Error?) -> Void){
        guard let url = URL(string: Constant.getAddressDetailsEndPoint())else{
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            do {
                guard let data = data else{
                    return
                }
                let decoder = JSONDecoder()
                let address = try decoder.decode(PostAdreesResponse.self, from: data)
               
                compelitionHandler(address.customerAddress,nil)
            } catch {
                print("default address error")
                compelitionHandler(nil, error)
            }
        }
        task.resume()
                
    }

}
