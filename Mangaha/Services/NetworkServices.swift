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
    static func getProductInfo( baseUrl : String , completionHandler : @escaping (myProduct?)->Void){
        guard let url = URL(string: baseUrl) else{return}
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            do {
                guard let data = data else{return}
                let jsonData = try JSONDecoder().decode(myProduct.self, from: data)
                completionHandler(jsonData)
            }catch{
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
        task.resume()
    }
    static func postCustomer(customer : userCustomer , completionHandler : @escaping (ResponseCustomer? , Error?)->Void){
        guard let url = URL(string: Constant.postCustomerEndPoint())else{
            return
        }
        guard let Base = URL(string: "https://mad43-alex-ios3.myshopify.com/admin/api/2023-04/customers.json") else {return}
        var request = URLRequest(url: Base)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("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", forHTTPHeaderField: "X-Shopify-Access-Token")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: convertToParameters(customer: customer), options: .prettyPrinted) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Request error:", error)
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let responseModel = try decoder.decode(ResponseUser.self, from: data)
                    let customer = responseModel.customer
                    completionHandler(customer,nil)
                } catch {
                    print(error.localizedDescription)
                    completionHandler(nil,error)
                    return
                }
            }
        }
        task.resume()
    }
    static func convertToParameters(customer : userCustomer) -> [String: Any] {
        var parameters: [String: Any] = [:]
        parameters["customer"] = convertCustomerTOParameters(customer: customer.customer)
        return parameters
    }
    
    static func convertCustomerTOParameters(customer:Customer)->[String:Any]{
        var parameters : [String:Any] = [:]
        parameters["first_name"] = customer.firstName
        parameters["email"] = customer.email
        parameters["verified_email"] = customer.verifiedEmail
        parameters["password"] = customer.password
        parameters["password_confirmation"] = customer.passwordConfirmation
        parameters["send_email_welcome"] = customer.sendEmailWelcome
        
        return parameters
    }
    static func postDraftOrder(products:[LineItems],completionHandler : @escaping (DraftOrderResponse? , Error?)->Void){
        let url = URL(string: "https://0f0340065b43e0803729efbf5c2e1ff6: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@mad43-alex-ios3.myshopify.com/admin/api/2023-04/draft_orders.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let session = URLSession.shared
        request.httpShouldHandleCookies = false
        
        do {
            let order = DraftOrderRequest(draftOrder: DraftOrder(lineItems: products))
            let data = try JSONEncoder().encode(order)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            request.httpBody = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        }catch let error {
            print("error post")
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completionHandler(nil , error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                do {
                    let json = try JSONDecoder().decode(DraftOrderPostResponse.self, from: data!)
                    print(json.draftOrder?.lineItems)
                    completionHandler(json.draftOrder , nil)
                } catch {
                    print("erro decoding")
                    completionHandler(nil , error)
                }
                return
            }
            
        }.resume()
    }
    
    static func deleteDraftOrder(id:Int){
        guard let url = URL(string: Constant.DraftOrderEndPoint(id: id)) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
       
        }

        task.resume()
    }
    
    static func getDraftOrder(id :Int , completionHandler:@escaping (DraftOrderResponse? , Error?)->Void){
        guard let url = URL(string: Constant.DraftOrderEndPoint(id: id)) else{return}
        print(url)
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            do {
                guard let data = data else{return}
                let jsonData = try JSONDecoder().decode(DraftOrderGetResponse.self, from: data)
                print("data is here")
                completionHandler(jsonData.draftOrder,nil)
            }catch{
                print("error decoding")
                print(error.localizedDescription)
                completionHandler(nil,error)
            }
        }
        task.resume()
        
    }
}
