//
//  DraftOrderModel.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 15/06/2023.
//

import Foundation
struct DraftOrderRequest : Codable{
    var draftOrder : DraftOrder
    enum CodingKeys : String , CodingKey{
        case draftOrder = "draft_order"
    }
}
struct DraftOrder : Codable{
    var lineItems : [LineItems]?
    enum CodingKeys: String, CodingKey {
        case lineItems = "line_items"
    }
}
struct LineItems : Codable{
    var title    : String?
    var price    : String?
    var quantity : Int?
    enum CodingKeys: String, CodingKey {
        case title
        case price
        case quantity
    }
    
}
struct DraftOrderPostResponse : Codable{
   var draftOrder : DraftOrderResponse?
    enum CodingKeys: String, CodingKey {
      case draftOrder = "draft_order"
    }
}
struct DraftOrderResponse : Codable {
    var id : Int?
    var lineItems: [LineItems]?
    enum CodingKeys: String, CodingKey {
        case id  = "id"
        case lineItems = "line_items"
    }
}

