//
//  OderViewModel.swift
//  Mangaha
//
//  Created by mariam adly on 19/06/2023.
//

import Foundation
class OrderViewModel{
    var bindOrderListToOrderVC : (()->()) = {}
    var ordersList : [Order]? {
        didSet {
            bindOrderListToOrderVC()
        }
    }

    func getOrderss(baseUrl:String){
        NetworkServices.getOrders(url: baseUrl){
            [weak self] result,error  in
            self?.ordersList = result?.orders
        }
    }
    
    func getOrdersAtIndex(index:Int)-> Order{
        return ordersList?[index] ?? Order()
    }
    
    func  getOrderssCount()->Int{
        return ordersList?.count ?? 0
    }
}
