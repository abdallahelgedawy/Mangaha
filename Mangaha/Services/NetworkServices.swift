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
    
   static func convertCurency(amount:String,completionHandler: @escaping (Double?) -> Void ){
       let currency = getCurrency()
       let url : URL?
       if currency == "EGP"{
           url = URL(string: Constant.currencyConverterUrl("EGP", "Eur", amount))
       }else{
           url = URL(string: Constant.currencyConverterUrl("Eur", "EGP", amount))
       }
        guard let url = url else{
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(CurrencyConverter.self, from: data!)
                completionHandler(result.result)
                
            }catch let error{
                print(error.localizedDescription)
                completionHandler(nil)
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

}
