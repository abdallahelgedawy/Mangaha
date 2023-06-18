//
//  PrdouctDetailsViewModel.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 08/06/2023.
//

import Foundation
class ProductDetailsViewModel{
    var productId : Int?
    var bindproductInfoListToProductDetailsVC : (()->()) = {}
    var bindedResultPrice :(()->()) = {}
    var convertedPrice : String? = nil
    var productInfo : myProduct?{
        didSet{
            bindproductInfoListToProductDetailsVC()
        }
    }
    func getProductsInfo(baseUrl : String){
        NetworkServices.getProductInfo(baseUrl: baseUrl) { myProductInfo in
            if Constant.isEuroCurrency() == false {
                print(self.productInfo?.product.variants?[0].price)
                NetworkServices.convertCurency(amount: myProductInfo?.product.variants?[0].price ?? "") { convertedPrice, error in
                    self.productInfo = myProductInfo
                    self.productInfo?.product.variants?[0].price = String(convertedPrice ?? 0.0)
                   
                    print(convertedPrice)
                }
            }
            else {
        
            self.productInfo = myProductInfo
            }
        }
        DispatchQueue.main.async {
            self.bindedResultPrice()
        }
    }
    
    func getImagesAtIndex(index : Int)->(Images){
        return productInfo?.product.images?[index] ?? Images(id: 0, product_id: 0, position: 0, created_at: "", updated_at: "", alt: "", width: 0, height: 0, src: "", variant_ids: [], admin_graphql_api_id: "")
    }
    func getImagesCount()->Int{
        return productInfo?.product.images?.count ?? 0
    }
    func getProductAtIndex(index : Int)->myProduct?{
        return productInfo
    }
   /* func setConvertedPrice(price : String , completionHandler : @escaping (String)->Void){
        NetworkServices.convertCurency(amount: productInfo?.product.variants?[0].price ?? "0.0") { myPrice, error in
            self.convertedPrice = String(myPrice ?? 0.0)
            self.productInfo?.product.variants?[0].price = self.convertedPrice
        }
        DispatchQueue.main.async {
            self.bindedResultPrice()
        }
    }*/
}
  
        
   /* func getonvertedPrice()->String{
        return convertedPrice ?? "0.0"
    }*/
   


