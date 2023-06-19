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
        let createdAt: Date
        let currentSubtotalPrice: String
        let currentTotalDiscounts: String
        let currentTotalPrice: String
        let currentTotalTax: String
        let email: String
        let name: String
        let number, orderNumber: Int
        let orderStatusURL: String
        let phone, poNumber: String
        let processedAt: Date
        let reference: String
        let referringSite: String
        let sourceIdentifier, sourceName: String
        let subtotalPrice: String
        let tags: String
        let taxesIncluded, test: Bool
        let token, totalDiscounts: String
        let totalLineItemsPrice: String
        let totalOutstanding, totalPrice: String
        let totalTax: String
        let totalTipReceived: String
        let totalWeight: Int
        let updatedAt: Date
        let customer: Customer
        let lineItems: [LineItem]
}
