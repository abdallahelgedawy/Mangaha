//
//  FavoriteViewModel.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 07/06/2023.
//

import Foundation
class FavoriteViewModel{
    let dataBase = DataBase()
    var favourites = [CartProduct]()
    var bindedResult : (()->()) = {}
    func getFavouritProducts(){
        if let products = dataBase.getFavouriteProducts(){
            favourites = products
        }
        
    }
    
    func getProductByIndex(_ index:Int)->CartProduct{
        return favourites[index]
    }
    
    
    func deleteFromFavourites(_ id:String , _ index:Int){
        dataBase.deleteProductFromDataBase(id: id, isFavourite: true)
        favourites.remove(at: index)
    }
    func deleteFavourites(_ id:String){
        dataBase.deleteProductFromDataBase(id: id, isFavourite: true)
        //print(index)
       // favourites.remove(at: index)
    }
    
    func getFavouritesCount()->Int{
        return favourites.count
    }
    func inistintiateProductDetVM(_ index : Int)->ProductDetailsViewModel{
        var productDetVM = ProductDetailsViewModel()
        productDetVM.productId = Int(favourites[index].id ?? "")
        return productDetVM
    }
}
