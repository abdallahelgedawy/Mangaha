//
//  ProductsResponse.swift
//  MangahaTests
//
//  Created by mariam adly on 19/06/2023.
//

import Foundation
@testable import Mangaha

class MockProductsResponse{
   static var productsResponse = """
       {
           "products": [
               {
                   "id": 8398222688542,
                   "title": "ADIDAS | CLASSIC BACKPACK",
                   "body_html": "This women's backpack has a glam look, thanks to a faux-leather build with an allover fur print. The front zip pocket keeps small things within reach, while an interior divider reins in potential chaos.",
                   "vendor": "ADIDAS",
                   "product_type": "ACCESSORIES",
                   "created_at": "2023-06-12T22:39:09-04:00",
                   "handle": "adidas-classic-backpack",
                   "updated_at": "2023-06-12T22:40:11-04:00",
                   "published_at": "2023-06-12T22:39:09-04:00",

                   "status": "active",
                   "published_scope": "global",
                   "tags": "adidas, backpack, egnition-sample-data",
                   "admin_graphql_api_id": "gid://shopify/Product/8398222688542",
                  },
               {
                          "id": 8398221443358,
                          "title": "DR MARTENS | 1461 DMC 3-EYE SHOE | BLACK SMOOTH",
                          "body_html": "Make a statement with the iconic Dr Marten's 1461Z DMC 3-Eye shoe. Stamped with Docs trademade look, this lace-up shoe is crafted with high-quality, durable smooth leather, and has been made to last. This unique shoe features an air-cushioned sole offering good abrasion and slip resistance, and is made with Goodyear welt - the sole and upper are heat-sealed and sewn together.",
                          "vendor": "DR MARTENS",
                          "product_type": "SHOES",
                          "created_at": "2023-06-12T22:38:16-04:00",
                          "handle": "dr-martens-1461-dmc-3-eye-shoe-black-smooth",
                          "updated_at": "2023-06-12T22:50:11-04:00",
                          "published_at": "2023-06-12T22:38:16-04:00",
                          "template_suffix": null,
                          "status": "active",
                          "published_scope": "global",
                          "tags": "autumn, drmartens, egnition-sample-data, spring, women",
                          "admin_graphql_api_id": "gid://shopify/Product/8398221443358"
}
]
}

"""
}
