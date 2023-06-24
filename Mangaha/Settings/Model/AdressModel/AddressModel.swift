//
//  AddressModel.swift
//  Mangaha
//
//  Created by ME on 12/06/2023.
//

import Foundation
struct AddressModel: Codable {
    let address: Address
}

struct Address: Codable {
    var address1:String?
    var city:String?
    var  phone :String?
    var countryName , country :String?
    enum CodingKeys: String, CodingKey {
        case address1
        case city
        case phone
        case country
        case countryName = "country_name"
    }
}

struct PostAdreesResponse: Codable {
    let customerAddress: CustomerAddress

    enum CodingKeys: String, CodingKey {
        case customerAddress = "customer_address"
    }
}
struct CustomerAddress: Codable {
    let id, customerID: Int
    let firstName, address1: String
    let  city: String
    let  phone, name: String
    let  countryName , country: String
    let customerAddressDefault: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case country
        case customerID = "customer_id"
        case firstName = "first_name"
        case  address1, city, phone, name
        case countryName = "country_name"
        case customerAddressDefault = "default"
    }
}



struct GetAddressModel:Codable{
    let addresses:[CustomerAddress]?
}
