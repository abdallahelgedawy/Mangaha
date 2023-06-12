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

}
