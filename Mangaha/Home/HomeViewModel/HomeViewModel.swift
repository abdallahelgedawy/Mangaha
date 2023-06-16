//
//  HomeViewModel.swift
//  Mangaha
//
//  Created by mariam adly on 10/06/2023.
//

import Foundation
class HomeViewModel{
    
    var brands : [Smart_collections]?
    var bindBrandsListToHomeVC : (()->()) = {}
    var brandsList : [Smart_collections]? {
        didSet {
            bindBrandsListToHomeVC()
        }
    }
    
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
    
}
