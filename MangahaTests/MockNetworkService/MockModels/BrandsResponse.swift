//
//  BrandsResponse.swift
//  MangahaTests
//
//  Created by mariam adly on 19/06/2023.
//

import Foundation
@testable import Mangaha

class MockBrandsResponse{
   static var brandsResponse = """
       {
           "smart_collections": [
               {
                   "id": 449560707358,
                   "handle": "adidas",
                   "title": "ADIDAS",
                   "updated_at": "2023-06-12T22:45:18-04:00",
                   "body_html": "Adidas collection",
                   "published_at": "2023-06-12T22:40:12-04:00",
                   "sort_order": "best-selling",
                   "template_suffix": null,
                   "disjunctive": false,
                   "rules": [
                       {
                           "column": "title",
                           "relation": "contains",
                           "condition": "ADIDAS"
                       }
                   ],
                   "published_scope": "web",
                   "admin_graphql_api_id": "gid://shopify/Collection/449560707358",
                   "image": {
                       "created_at": "2023-06-12T22:40:12-04:00",
                       "alt": null,
                       "width": 1000,
                       "height": 676,
                       "src": "https://cdn.shopify.com/s/files/1/0776/6048/7966/collections/97a3b1227876bf099d279fd38290e567.jpg?v=1686624012"
                   }
               },
               {
                   "id": 449560805662,
                   "handle": "asics-tiger",
                   "title": "ASICS TIGER",
                   "updated_at": "2023-06-12T22:45:16-04:00",
                   "body_html": "Asics Tiger collection",
                   "published_at": "2023-06-12T22:40:15-04:00",
                   "sort_order": "best-selling",
                   "template_suffix": null,
                   "disjunctive": false,
                   "rules": [
                       {
                           "column": "title",
                           "relation": "contains",
                           "condition": "ASICS TIGER"
                       }
                   ],
                   "published_scope": "web",
                   "admin_graphql_api_id": "gid://shopify/Collection/449560805662",
                   "image": {
                       "created_at": "2023-06-12T22:40:16-04:00",
                       "alt": null,
                       "width": 425,
                       "height": 220,
                       "src": "https://cdn.shopify.com/s/files/1/0776/6048/7966/collections/b351cead33b2b72e7177e70512530f09.jpg?v=1686624016"
                   }
               },
               {
                   "id": 449560772894,
                   "handle": "converse",
                   "title": "CONVERSE",
                   "updated_at": "2023-06-12T22:50:11-04:00",
                   "body_html": "Converse collection",
                   "published_at": "2023-06-12T22:40:14-04:00",
                   "sort_order": "best-selling",
                   "template_suffix": null,
                   "disjunctive": false,
                   "rules": [
                       {
                           "column": "title",
                           "relation": "contains",
                           "condition": "CONVERSE"
                       }
                   ],
                   "published_scope": "web",
                   "admin_graphql_api_id": "gid://shopify/Collection/449560772894",
                   "image": {
                       "created_at": "2023-06-12T22:40:14-04:00",
                       "alt": null,
                       "width": 2000,
                       "height": 1231,
                       "src": "https://cdn.shopify.com/s/files/1/0776/6048/7966/collections/1651743658af793833e0a0d9cf6a9c5d.png?v=1686624014"
                   }
               },
               {
                   "id": 449560969502,
                   "handle": "dr-martens",
                   "title": "DR MARTENS",
                   "updated_at": "2023-06-12T22:50:11-04:00",
                   "body_html": "Dr Martens collection",
                   "published_at": "2023-06-12T22:40:21-04:00",
                   "sort_order": "best-selling",
                   "template_suffix": null,
                   "disjunctive": false,
                   "rules": [
                       {
                           "column": "title",
                           "relation": "contains",
                           "condition": "DR MARTENS"
                       }
                   ],
                   "published_scope": "web",
                   "admin_graphql_api_id": "gid://shopify/Collection/449560969502",
                   "image": {
                       "created_at": "2023-06-12T22:40:21-04:00",
                       "alt": null,
                       "width": 220,
                       "height": 125,
                       "src": "https://cdn.shopify.com/s/files/1/0776/6048/7966/collections/a5f66d7e0c3e36ebbd2b7b632b2e4c47.jpg?v=1686624021"
                   }
               },
               {
                   "id": 449561035038,
                   "handle": "flex-fit",
                   "title": "FLEX FIT",
                   "updated_at": "2023-06-12T22:45:19-04:00",
                   "body_html": "Flex Fit collection",
                   "published_at": "2023-06-12T22:40:23-04:00",
                   "sort_order": "best-selling",
                   "template_suffix": null,
                   "disjunctive": false,
                   "rules": [
                       {
                           "column": "title",
                           "relation": "contains",
                           "condition": "FLEX FIT"
                       }
                   ],
                   "published_scope": "web",
                   "admin_graphql_api_id": "gid://shopify/Collection/449561035038",
                   "image": {
                       "created_at": "2023-06-12T22:40:23-04:00",
                       "alt": null,
                       "width": 195,
                       "height": 195,
                       "src": "https://cdn.shopify.com/s/files/1/0776/6048/7966/collections/0c892d0c64bcd739e0a7d96f3d7d9afd.png?v=1686624023"
                   }
               },
               {
                   "id": 449561002270,
                   "handle": "herschel",
                   "title": "HERSCHEL",
                   "updated_at": "2023-06-12T22:45:18-04:00",
                   "body_html": "Herschel collection",
                   "published_at": "2023-06-12T22:40:22-04:00",
                   "sort_order": "best-selling",
                   "template_suffix": null,
                   "disjunctive": false,
                   "rules": [
                       {
                           "column": "title",
                           "relation": "contains",
                           "condition": "HERSCHEL"
                       }
                   ],
                   "published_scope": "web",
                   "admin_graphql_api_id": "gid://shopify/Collection/449561002270",
                   "image": {
                       "created_at": "2023-06-12T22:40:22-04:00",
                       "alt": null,
                       "width": 250,
                       "height": 250,
                       "src": "https://cdn.shopify.com/s/files/1/0776/6048/7966/collections/7e6bb0fa16ee31d6537c58e4d9d453a8.png?v=1686624022"
                   }
               },
               {
                   "id": 449560740126,
                   "handle": "nike",
                   "title": "NIKE",
                   "updated_at": "2023-06-12T22:50:11-04:00",
                   "body_html": "Nike collection",
                   "published_at": "2023-06-12T22:40:13-04:00",
                   "sort_order": "best-selling",
                   "template_suffix": null,
                   "disjunctive": false,
                   "rules": [
                       {
                           "column": "title",
                           "relation": "contains",
                           "condition": "NIKE"
                       }
                   ],
                   "published_scope": "web",
                   "admin_graphql_api_id": "gid://shopify/Collection/449560740126",
                   "image": {
                       "created_at": "2023-06-12T22:40:13-04:00",
                       "alt": null,
                       "width": 308,
                       "height": 164,
                       "src": "https://cdn.shopify.com/s/files/1/0776/6048/7966/collections/52e93c3a86b9b62e023e5977ab218302.png?v=1686624013"
                   }
               },
               {
                   "id": 449560838430,
                   "handle": "palladuim",
                   "title": "PALLADUIM",
                   "updated_at": "2023-06-12T22:50:10-04:00",
                   "body_html": "Palladium collection",
                   "published_at": "2023-06-12T22:40:16-04:00",
                   "sort_order": "best-selling",
                   "template_suffix": null,
                   "disjunctive": false,
                   "rules": [
                       {
                           "column": "title",
                           "relation": "contains",
                           "condition": "PALLADIUM"
                       }
                   ],
                   "published_scope": "web",
                   "admin_graphql_api_id": "gid://shopify/Collection/449560838430",
                   "image": {
                       "created_at": "2023-06-12T22:40:17-04:00",
                       "alt": null,
                       "width": 195,
                       "height": 195,
                       "src": "https://cdn.shopify.com/s/files/1/0776/6048/7966/collections/8300014746383175003dc61767159d34.png?v=1686624017"
                   }
               },
               {
                   "id": 449560871198,
                   "handle": "puma",
                   "title": "PUMA",
                   "updated_at": "2023-06-12T22:45:17-04:00",
                   "body_html": "Puma collection",
                   "published_at": "2023-06-12T22:40:18-04:00",
                   "sort_order": "best-selling",
                   "template_suffix": null,
                   "disjunctive": false,
                   "rules": [
                       {
                           "column": "title",
                           "relation": "contains",
                           "condition": "PUMA"
                       }
                   ],
                   "published_scope": "web",
                   "admin_graphql_api_id": "gid://shopify/Collection/449560871198",
                   "image": {
                       "created_at": "2023-06-12T22:40:18-04:00",
                       "alt": null,
                       "width": 730,
                       "height": 365,
                       "src": "https://cdn.shopify.com/s/files/1/0776/6048/7966/collections/ffcaaa66e8de92f803f3440640e9f676.jpg?v=1686624018"
                   }
               },
               {
                   "id": 449560903966,
                   "handle": "supra",
                   "title": "SUPRA",
                   "updated_at": "2023-06-12T22:45:17-04:00",
                   "body_html": "Supra collection",
                   "published_at": "2023-06-12T22:40:19-04:00",
                   "sort_order": "best-selling",
                   "template_suffix": null,
                   "disjunctive": false,
                   "rules": [
                       {
                           "column": "title",
                           "relation": "contains",
                           "condition": "SUPRA"
                       }
                   ],
                   "published_scope": "web",
                   "admin_graphql_api_id": "gid://shopify/Collection/449560903966",
                   "image": {
                       "created_at": "2023-06-12T22:40:19-04:00",
                       "alt": null,
                       "width": 333,
                       "height": 250,
                       "src": "https://cdn.shopify.com/s/files/1/0776/6048/7966/collections/df080c448876c51c09b759c507db18c5.jpg?v=1686624019"
                   }
               },
               {
                   "id": 449560936734,
                   "handle": "timberland",
                   "title": "TIMBERLAND",
                   "updated_at": "2023-06-12T22:45:17-04:00",
                   "body_html": "Timberland collection",
                   "published_at": "2023-06-12T22:40:20-04:00",
                   "sort_order": "best-selling",
                   "template_suffix": null,
                   "disjunctive": false,
                   "rules": [
                       {
                           "column": "title",
                           "relation": "contains",
                           "condition": "TIMBERLAND"
                       }
                   ],
                   "published_scope": "web",
                   "admin_graphql_api_id": "gid://shopify/Collection/449560936734",
                   "image": {
                       "created_at": "2023-06-12T22:40:20-04:00",
                       "alt": null,
                       "width": 700,
                       "height": 700,
                       "src": "https://cdn.shopify.com/s/files/1/0776/6048/7966/collections/de257d81c4c71c6a281b05f0e79b057c.jpg?v=1686624020"
                   }
               },
               {
                   "id": 449560674590,
                   "handle": "vans",
                   "title": "VANS",
                   "updated_at": "2023-06-12T22:50:11-04:00",
                   "body_html": "Vans collection",
                   "published_at": "2023-06-12T22:40:11-04:00",
                   "sort_order": "best-selling",
                   "template_suffix": null,
                   "disjunctive": false,
                   "rules": [
                       {
                           "column": "title",
                           "relation": "contains",
                           "condition": "VANS"
                       }
                   ],
                   "published_scope": "web",
                   "admin_graphql_api_id": "gid://shopify/Collection/449560674590",
                   "image": {
                       "created_at": "2023-06-12T22:40:11-04:00",
                       "alt": null,
                       "width": 1610,
                       "height": 805,
                       "src": "https://cdn.shopify.com/s/files/1/0776/6048/7966/collections/a340ce89e0298e52c438ae79591e3284.jpg?v=1686624011"
                   }
               }
           ]
       }

"""
}
