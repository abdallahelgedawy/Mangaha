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
     var totalPrice = 0.0
    var totalBeforeDiscount = 0.0
    var address:CustomerAddress?
    var bindOrderListToPaymentVC : (()->()) = {}
    var ordersList : [LineItem]? {
        didSet {
            bindOrderListToPaymentVC()
        }
    }
    
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
    
    func convertCoreDataProductToLineItem()-> [LineItem] {
        getCartProducts()
        var lineItems = [LineItem]()
        for item in cartProducts{
            let  lineItem = LineItem(title: item.title ?? "", price: item.price ?? "", quantity: Int(item.quantity ?? "1") ?? 1)
            lineItems.append(lineItem)
        }
     return lineItems
    }
    
    func postOrder(url : String){
        let lineItems = convertCoreDataProductToLineItem()
        let customer = CustomerId(id: Int(Constant.getCurrentCustomerId()))
        NetworkServices.postOrder(url: url ,order: PostOrder(order: Order(line_items: lineItems,customer: customer))){
            [weak self] order, error in
            
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
            subTotal += (Double(product.price ?? "0.0") ?? 0.0) * (Double(product.quantity ?? "0.0") ?? 1)
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
    
    func inistintiateDonePaymentViewModel()->PaymentDoneViewModel{
        var donePayment = PaymentDoneViewModel()
        donePayment.address = address
        return donePayment
    }
}
