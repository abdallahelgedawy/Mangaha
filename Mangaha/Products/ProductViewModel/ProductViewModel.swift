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
        return productList?[index] ?? Products()
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
}
