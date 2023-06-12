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
        return brandsList?[index] ?? Smart_collections(id: 0, handle: "", title: "", updated_at: "", body_html: "", published_at: "", sort_order: "", template_suffix: "", disjunctive: true, rules: [Rules(column: "", relation: "", condition: "")], published_scope: "", admin_graphql_api_id: "", image: Image(created_at: "", alt: "", width: 0, height: 0, src: ""))
    }
    
    func  getBrandsCount()->Int{
        return brandsList?.count ?? 0
    }
    
    func inistintiateProductViewModel(index:Int)-> ProductViewModel{
        let productViewModeL = ProductViewModel()
        productViewModeL.brandId = brandsList?[index].id
        return productViewModeL
    }
    
}
