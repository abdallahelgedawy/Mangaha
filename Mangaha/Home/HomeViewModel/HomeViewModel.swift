//
//  HomeViewModel.swift
//  Mangaha
//
//  Created by mariam adly on 10/06/2023.
//

import Foundation
class HomeViewModel{
    var bindBrandsListToHomeVC : (()->()) = {}
    var barndsList : [Smart_collections]? {
        didSet {
            bindBrandsListToHomeVC()
        }
    }
    
    func getBrands(){
        NetworkServices.getBrands(){
            [weak self] result in
            self?.barndsList = result?.smart_collections
        }
    }
}
