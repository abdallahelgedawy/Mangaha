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
                print("here",error.localizedDescription)
                completionHandler(nil,error)
            }
            
        }
        task.resume()
    }
    
    static func getCurrency()->String{
        if let currency =  UserDefaults.standard.object(forKey: Constant.currencyKey) as? String{
            return currency
        }
        return "Eur"
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
    static func postDraftOrder(completionHandler : @escaping (DraftOrderResponse? , Error?)->Void){
        let url = URL(string: "https://0f0340065b43e0803729efbf5c2e1ff6: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@mad43-alex-ios3.myshopify.com/admin/api/2023-04/draft_orders.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let session = URLSession.shared
        request.httpShouldHandleCookies = false
        
        do {
            let lineItems = [LineItems(title: "first" , price: "10" , quantity: 1)]
            let order = DraftOrderRequest(draftOrder: DraftOrder(lineItems: lineItems))
            let data = try JSONEncoder().encode(order)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            request.httpBody = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        }catch let error {
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
                    print(json.draftOrder?.id)
                    completionHandler(json.draftOrder , nil)
                } catch {
                    completionHandler(nil , error)
                }
                return
            }
            
        }.resume()
    }
    
}
