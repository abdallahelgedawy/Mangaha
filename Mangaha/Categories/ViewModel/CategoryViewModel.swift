//
//  CategoryViewModel.swift
//  Mangaha
//
//  Created by mariam adly on 10/06/2023.
//

import Foundation
class CategoryViewModel{
    var bindCategoryListToCategoryVC : (()->()) = {}
    var categoriesList : [Products]? {
        didSet {
            bindCategoryListToCategoryVC()
        }
    }
    var bindResult : (()->()) = {}
    var currency : Double?{
        didSet {
            bindResult()
        }
    }
    
    func getProducts(baseUrl:String){
        NetworkServices.getProducts(baseUrl: baseUrl){
            [weak self] result in
            self?.categoriesList = result?.products
        }
    }
    
    func getProductsAtIndex(index:Int)-> Products{
        return categoriesList?[index] ?? Products()
    }
    
    func  getProductsCount()->Int{
        return categoriesList?.count ?? 0
    }
    
 /*   func getCurrency(amount:String){
        NetworkServices.convertCurency(amount: amount){
            [weak self] result in
            self?.currency = result
        }
    }
  */
    func instantiateProductDetailsViewModel(index : Int) -> ProductDetailsViewModel{
        var productDetailsViewModel = ProductDetailsViewModel()
        productDetailsViewModel.productId = categoriesList?[index].id
        return productDetailsViewModel
    }
    func takeProducts(){
        
    }
}
