//
//  PaymentViewModel.swift
//  Mangaha
//
//  Created by ME on 18/06/2023.
//

import Foundation
import PassKit
class PaymentViewModel{
    var dataBase = DataBase()
    var coupouns = [String]()
    private var cartProducts = [CartProduct]()
    private var subTotal = 0.0
    private var totalPrice = 0.0
    var totalBeforeDiscount = 0.0
    
    func setupCopouns(){
        let firstC = UserDefaults.standard.object(forKey: "FirstC") as? String ?? "none"
        print(firstC)
        let secondC = UserDefaults.standard.object(forKey: "SecondC") as? String ?? "none"
        print(secondC)
        let thirdC = UserDefaults.standard.object(forKey: "ThirdC") as? String ?? "none"
        print(thirdC)
        if firstC != "none"{
            coupouns.append(firstC)
        }
        if secondC != "none"{
            coupouns.append(secondC)
        }
        if thirdC != "none"{
            coupouns.append(thirdC)
        }
    }
    
    
    func getCoupouns()->[String]{
        return coupouns
    }
    
    func getCopounsCount()->Int{
        return coupouns.count
    }
    
    private func getCartProducts(){
        if let products  = dataBase.getCartProducts(){
            cartProducts =  products
        }
        
    }
    
    private func calculateSubTotal(){
        for product in cartProducts{
            subTotal += Double(product.price ?? "0.0") ?? 0.0
        }
    }
    
    func getSubTotal()->String{
        getCartProducts()
        calculateSubTotal()
        return String(format: "%.2f", subTotal)
    }
    
    private func calculateTotalPrice( _ dicountPercent:Double){
        if Constant.isEuroCurrency(){
            totalBeforeDiscount = subTotal + 5
            
        }else{
            totalBeforeDiscount = subTotal + 35
        }
        totalPrice = totalBeforeDiscount * dicountPercent
    }
    
    func getTotalPrice(dicountPercent:Double = 1.0)->String{
        calculateTotalPrice(dicountPercent)
        return String(format: "%.2f", totalPrice)
    }
    func caluculateDiscountAmount(discountPercent:Double)->String{
        let discountAmount = totalBeforeDiscount * (1.0 - discountPercent)
        return String(format: "%.2f", discountAmount)
    }
    
    func getPaymentRequest() -> PKPaymentRequest {
          let request = PKPaymentRequest()
            request.merchantIdentifier = Constant.MARCHANT_ID
            request.supportedNetworks = [.quicPay, .masterCard, .visa]
            request.supportedCountries = ["EG", "ES"]
            request.merchantCapabilities = .capability3DS

        if Constant.isEuroCurrency() == false {
                request.countryCode = "EG"
                request.currencyCode = "EGP"
         } else {
             request.countryCode = "ES"
             request.currencyCode = "EUR"
           }
              request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Shopify", amount: NSDecimalNumber(value: totalPrice ))]
            return request
        }
}
