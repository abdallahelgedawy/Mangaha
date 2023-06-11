//
//  Brands.swift
//  Mangaha
//
//  Created by mariam adly on 10/06/2023.
//

import Foundation
struct Brands : Codable {
    let smart_collections : [Smart_collections]?
}
struct Smart_collections : Codable {
    let id : Int?
    let handle : String?
    let title : String?
    let updated_at : String?
    let body_html : String?
    let published_at : String?
    let sort_order : String?
    let template_suffix : String?
    let disjunctive : Bool?
    let rules : [Rules]?
    let published_scope : String?
    let admin_graphql_api_id : String?
    let image : Image?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case handle = "handle"
        case title = "title"
        case updated_at = "updated_at"
        case body_html = "body_html"
        case published_at = "published_at"
        case sort_order = "sort_order"
        case template_suffix = "template_suffix"
        case disjunctive = "disjunctive"
        case rules = "rules"
        case published_scope = "published_scope"
        case admin_graphql_api_id = "admin_graphql_api_id"
        case image = "image"
    }

   

}
struct Rules : Codable {
    let column : String?
    let relation : String?
    let condition : String?

    enum CodingKeys: String, CodingKey {

        case column = "column"
        case relation = "relation"
        case condition = "condition"
    }


}
struct Image : Codable {
    let created_at : String?
    let alt : String?
    let width : Int?
    let height : Int?
    let src : String?

    enum CodingKeys: String, CodingKey {

        case created_at = "created_at"
        case alt = "alt"
        case width = "width"
        case height = "height"
        case src = "src"
    }

}
