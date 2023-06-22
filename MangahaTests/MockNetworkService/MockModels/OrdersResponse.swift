//
//  OrdersResponse.swift
//  MangahaTests
//
//  Created by mariam adly on 21/06/2023.
//

import Foundation
class MockOrderResponse{
    static var orderResponse = """
  {
      "orders": [
          {
            "id": 123,
            "created_at": "2023-06-21T10:30:00Z",
            "current_subtotal_price": "50.00",
            "current_total_discounts": "10.00",
            "current_total_price": "40.00",
            "current_total_tax": "5.00",
            "email": "john@example.com",
            "name": "John Doe",
            "number": 1,
            "order_number": 12345,
            "order_status_url": "https://example.com/order/12345",
            "phone": "1234567890",
            "poNumber": "PO123",
            "processed_at": "2023-06-21T10:35:00Z",
            "reference": "REF123",
            "referring_site": "Example Site",
            "source_identifier": "SOURCE123",
            "source_name": "Example Source",
            "subtotal_price": "50.00",
            "tags": "tag1, tag2",
            "taxes_included": true,
            "test": false,
            "token": "TOKEN123",
            "total_discounts": "10.00",
            "total_line_items_price": "60.00",
            "total_outstanding": "20.00",
            "total_price": "40.00",
            "total_tax": "5.00",
            "total_tip_received": "2.50",
            "total_weight": 100,
            "updated_at": "2023-06-21T10:40:00Z",
            "customer": {
              "id": 1,
              "first_name": "John",
              "last_name": "Doe",
              "email": "john@example.com"
            },
            "line_items": [
              {
                "id": 1,
                "title": "Product 1",
                "price": "20.00",
                "quantity": 2
              },
              {
                "id": 2,
                "title": "Product 2",
                "price": "10.00",
                "quantity": 1
              }
            ]
          }
          

      ]
  }
"""
    
    static var draftOrder = """
                   {
                     "draft_order": {
                       "id": 1053317318,
                        "line_items": [
                               {
                                 "title": 1053317318,
                                 "price": 207119551,
                                 "quantity": "Samuel",
                                 "sku": "Fancy Co.",
                               }
                             ]
                     }
                   }
"""
    
    static var postOrder = """
                   {
                     "order": {
                       "id": 1053317318,
                        "createdAt": null,
                     }
                   }
"""
}
