//
//  Brands.swift
//  Mangaha
//
//  Created by mariam adly on 10/06/2023.
//

import Foundation
struct Brands : Codable {
    var smart_collections : [Smart_collections]?
}
struct Smart_collections : Codable {
    var id : Int?
    var handle : String?
    var title : String?
    var updated_at : String?
    var body_html : String?
    var published_at : String?
    var sort_order : String?
    var template_suffix : String?
    var disjunctive : Bool?
    var rules : [Rules]?
    var published_scope : String?
    var admin_graphql_api_id : String?
    var image : Image?

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
    var column : String?
    var relation : String?
    var condition : String?

    enum CodingKeys: String, CodingKey {

        case column = "column"
        case relation = "relation"
        case condition = "condition"
    }


}
struct Image : Codable {
    var created_at : String?
    var alt : String?
    var width : Int?
    var height : Int?
    var src : String?

    enum CodingKeys: String, CodingKey {

        case created_at = "created_at"
        case alt = "alt"
        case width = "width"
        case height = "height"
        case src = "src"
    }

}
