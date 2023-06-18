//
//  ProductViewModel.swift
//  Mangaha
//
//  Created by mariam adly on 11/06/2023.
//

import Foundation
class ProductViewModel{
    let dataBase = DataBase()
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
    func instantiateProductDetailsViewModel(index : Int)->ProductDetailsViewModel{
        let productDetailsViewModel = ProductDetailsViewModel()
        productDetailsViewModel.productId = productList?[index].id
        return productDetailsViewModel
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
