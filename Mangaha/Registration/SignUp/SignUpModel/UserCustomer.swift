//
//  UserCustomer.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 14/06/2023.
//

import Foundation
struct userCustomer: Codable {
    let customer: Customer
}
struct Customer: Codable {
    let firstName,email: String
    let verifiedEmail: Bool
    let password, passwordConfirmation: String
    let sendEmailWelcome: Bool
    

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case email
        case verifiedEmail = "verified_email"
        case password
        case passwordConfirmation = "password_confirmation"
        case sendEmailWelcome = "send_email_welcome"
    }
}
struct ResponseUser: Codable {
    let customer: ResponseCustomer
}

// MARK: - Customer
struct ResponseCustomer: Codable {
    let id: Int
    let firstName : String
    enum CodingKeys : String , CodingKey{
        case id
        case firstName = "first_name"
     
    }
}
