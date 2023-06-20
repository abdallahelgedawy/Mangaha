//
//  HomeViewModel.swift
//  Mangaha
//
//  Created by mariam adly on 10/06/2023.
//

import Foundation
import FirebaseFirestore
class HomeViewModel{
    let db = Firestore.firestore()
    var brands : [Smart_collections]?
    var bindBrandsListToHomeVC : (()->()) = {}
    var brandsList : [Smart_collections]? {
        didSet {
            bindBrandsListToHomeVC()
        }
    }
    let copouns = ["MANGAHA10" , "MANGAHA20" , "MANGAHA30"]
    func getBrands(baseUrl: String){
        NetworkServices.getBrands(baseUrl: baseUrl){
            [weak self] result in
            self?.brandsList = result?.smart_collections
        }
    }
    
    func getBrandsAtIndex(index:Int)-> Smart_collections{
        return brandsList?[index] ?? Smart_collections()
    }
    
    func  getBrandsCount()->Int{
        return brandsList?.count ?? 0
    }
    
    func inistintiateProductViewModel(index:Int)-> ProductViewModel{
        let productViewModeL = ProductViewModel()
        productViewModeL.brandId = brandsList?[index].id
        return productViewModeL
    }
    func instantiateFilterProductViewModel(index : Int , filterList : [Smart_collections]) -> ProductViewModel{
        let productViewModel = ProductViewModel()
        productViewModel.brandId = filterList[index].id
        return productViewModel
    }
    func createUserDefualtsCoupons(){
        UserDefaults.standard.set("none", forKey: "FirstC")
        UserDefaults.standard.set("none", forKey: "SecondC")
        UserDefaults.standard.set("none", forKey: "ThirdC")
        
    }
    
    func addCoupounsToUserDefaults(copounCode:String){
        if UserDefaults.standard.object(forKey: "FirstC") as? String == "none"{
            UserDefaults.standard.set(copounCode, forKey: "FirstC")
        }else if UserDefaults.standard.object(forKey: "SecondC") as? String == "none"{
            UserDefaults.standard.set(copounCode, forKey: "SecondC")
        }else if UserDefaults.standard.object(forKey: "ThirdC") as? String == "none"{
            UserDefaults.standard.set(copounCode, forKey: "ThirdC")
        }else{
            UserDefaults.standard.set(copounCode, forKey: "FirstC")
        }
    }
    
    func getCopunAtIndex(index:Int)->String{
        return copouns[index]
    }
    
}
