//
//  Category.swift
//  Mangaha
//
//  Created by mariam adly on 10/06/2023.
//

import Foundation
struct Product : Codable {
    let products : [Products]?
}
struct Products : Codable {
    let id : Int?
    let title : String?
    let body_html : String?
    let vendor : String?
    let product_type : String?
    let created_at : String?
    let handle : String?
    let updated_at : String?
    let published_at : String?
    let template_suffix : String?
    let status : String?
    let published_scope : String?
    let tags : String?
    let admin_graphql_api_id : String?
    let variants : [Variants]?
    let options : [Options]?
    let images : [Images]?
    let image : Images?
}
struct Options : Codable {
    let id : Int?
    let product_id : Int?
    let name : String?
    let position : Int?
    let values : [String]?

}
struct Variants : Codable {
    let id : Int?
    let product_id : Int?
    let title : String?
    let price : String?
    let sku : String?
    let position : Int?
    let inventory_policy : String?
    let compare_at_price : String?
    let fulfillment_service : String?
    let inventory_management : String?
    let option1 : String?
    let option2 : String?
    let option3 : String?
    let created_at : String?
    let updated_at : String?
    let taxable : Bool?
    let barcode : String?
    let grams : Int?
    let image_id : String?
    let weight : Double?
    let weight_unit : String?
    let inventory_item_id : Int?
    let inventory_quantity : Int?
    let old_inventory_quantity : Int?
    let requires_shipping : Bool?
    let admin_graphql_api_id : String?

}
struct Images : Codable {
    let id : Int?
    let product_id : Int?
    let position : Int?
    let created_at : String?
    let updated_at : String?
    let alt : String?
    let width : Int?
    let height : Int?
    let src : String?
    let variant_ids : [String]?
    let admin_graphql_api_id : String?
}



