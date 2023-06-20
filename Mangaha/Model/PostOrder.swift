//
//  PostOrder.swift
//  Mangaha
//
//  Created by mariam adly on 19/06/2023.
//

import Foundation
struct PostOrder: Codable {
    let order: Order
    
}
struct Order: Codable {
    var line_items    : [LineItem]?
    var customer : CustomerId?
    var created_at : String?
}
struct CustomerId: Codable {
    let id : Int?
    
}
struct LineItem: Codable {
    let title: String
    let price: String
    let quantity: Int
}
    
struct ResponseOrder: Codable {
    let order: OrderInfo
}
struct OrderInfo: Codable {
    let id: Int
    var createdAt: Date?
}
