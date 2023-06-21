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
              "line_items": [
                  {
                    "title": "ay 7aga tania",
                      "price": "550.00",
                      "quantity": 5,
                  }
              ]
              "customer": {
                  "id":100000,
                  }
                "created_at": "2023-06-20T04:39:41-04:00",
          }
      ]
  }
"""
}
