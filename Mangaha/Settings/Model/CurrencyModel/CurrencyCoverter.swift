//
//  CurrencyCoverter.swift
//  Mangaha
//
//  Created by ME on 12/06/2023.
//

import Foundation
struct CurrencyConverter:Codable{
    var date: String?
    var historical: Bool?
    var info: Information?
    var query:Query?
    var  result:Double
    var  success: Bool?
}
struct Information :Codable{
    var quote: Double?
    var timestamp:Int?
}
struct Query:Codable{
    var  amount:Double?
    var  from: String?
    var to: String?
}
