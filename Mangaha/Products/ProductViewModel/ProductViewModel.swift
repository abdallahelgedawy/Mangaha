//
//  ProductViewModel.swift
//  Mangaha
//
//  Created by mariam adly on 11/06/2023.
//

import Foundation
class ProductViewModel{

    var brandId : Int?

    var bindproductListToProductVC : (()->()) = {}
    var productList : [Products]? {
        didSet {
            bindproductListToProductVC()
        }
    }
    
    func getProducts(baseUrl:String){
        NetworkServices.getProducts(baseUrl: baseUrl){
            [weak self] result in
            self?.productList = result?.products
            print(self?.brandId)
        }
    }
    
    func getProductsAtIndex(index:Int)-> Products{
        return productList?[index] ?? Products(id: 0, title: "", body_html: "", vendor: "", product_type: "", created_at: "", handle: "", updated_at: "", published_at: "", template_suffix: "", status: "", published_scope: "", tags: "", admin_graphql_api_id: "", variants: [Variants(id: 0, product_id: 0, title: "", price: "", sku: "", position: 0, inventory_policy: "", compare_at_price: "", fulfillment_service: "", inventory_management: "", option1: "", option2: "", option3: "", created_at: "", updated_at: "", taxable: true, barcode: "", grams: 0, image_id: "", weight: 0.0, weight_unit: "", inventory_item_id: 0, inventory_quantity: 0, old_inventory_quantity: 0, requires_shipping: true, admin_graphql_api_id: "")], options: [Options(id: 0, product_id: 0, name: "", position: 0, values: [""])], images: [Images(id: 0, product_id: 0, position: 0, created_at: "", updated_at: "", alt: "", width: 0, height: 0, src: "", variant_ids: [""], admin_graphql_api_id: "")], image: Images(id: 0, product_id: 0, position: 0, created_at: "", updated_at: "", alt: "", width: 0, height: 0, src: "", variant_ids: [""], admin_graphql_api_id: ""))
    }
    
    func  getProductsCount()->Int{
        return productList?.count ?? 0
    }
    
    func filterProductFromLowToHigh(){
        self.productList?.sort{($0.variants![0].price! as NSString).doubleValue < ($1.variants![0].price! as NSString).doubleValue}
    }
    
    func filterProductFromHighToLow(){
        self.productList?.sort{($0.variants![0].price! as NSString).doubleValue > ($1.variants![0].price! as NSString).doubleValue}
    }
    func instantiateProductDetailsViewModel(index : Int)->ProductDetailsViewModel{
        let productDetailsViewModel = ProductDetailsViewModel()
        productDetailsViewModel.productId = productList?[index].id
        return productDetailsViewModel
    }
}
