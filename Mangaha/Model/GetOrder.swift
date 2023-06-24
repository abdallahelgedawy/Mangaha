//
//  GetOrder.swift
//  Mangaha
//
//  Created by mariam adly on 19/06/2023.
//

import Foundation

struct GetOrder : Decodable {
    let orders: [Order]
}
struct OrderResult : Decodable {
    
        let id: Int
        let created_at: Date
        let current_subtotal_price: String
        let current_total_discounts: String
        let current_total_price: String
        let current_total_tax: String
        let email: String
        let name: String
        let number, order_number: Int
        let order_status_url: String
        let phone, poNumber: String
        let processed_at: Date
        let reference: String
        let referring_site: String
        let source_identifier, source_name: String
        let subtotal_price: String
        let tags: String
        let taxes_included, test: Bool
        let token, total_discounts: String
        let total_line_items_price: String
        let total_outstanding, total_price: String
        let total_tax: String
        let total_tip_received: String
        let total_weight: Int
        let updated_at: Date
        let customer: Customer
        let line_items: [LineItem]
}
