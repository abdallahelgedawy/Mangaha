//
//  CategoryViewModel.swift
//  Mangaha
//
//  Created by mariam adly on 10/06/2023.
//

import Foundation
class CategoryViewModel{
    let dataBase = DataBase()
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
    var filterList : [Products]?
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
    func instantiateCategoryFilteredViewModel(index : Int ,  filterList : [Products]?)->ProductDetailsViewModel{
        var productDetailsViewModel = ProductDetailsViewModel()
        productDetailsViewModel.productId = filterList?[index].id
        return productDetailsViewModel
        }
    func takeProducts(){
        
    }
    
    
    func addProductToFavourites(product:CoreDataProduct){
        dataBase.addToCart(product: product)
    }
    
    func deleteProductFromFavourite(_ id:String){
        dataBase.deleteProductFromDataBase(id: id, isFavourite: true)
    }
    func isInInfav(_ id:String)->Bool{
        return dataBase.isProductInFavourite(id: id)
    }
}
