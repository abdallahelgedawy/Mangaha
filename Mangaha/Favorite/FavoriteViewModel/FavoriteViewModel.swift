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
    func getFavouritProducts(){
        if let products = dataBase.getFavouriteProducts(){
            favourites = products
        }
    }
    
    func getProductByIndex(_ index:Int)->CartProduct{
        return favourites[index]
    }
    
    
    func deleteFromFavourites(_ id:String , isFav:Bool , _ index:Int){
        dataBase.deleteProductFromDataBase(id: id, isFavourite: true)
        favourites.remove(at: index)
    }
    
    func getFavouritesCount()->Int{
        return favourites.count
    }
    
}
