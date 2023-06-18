//
//  CartCell.swift
//  Mangaha
//
//  Created by ME on 08/06/2023.
//

import UIKit

class CartCell: UITableViewCell {
    var cartDelegate:cartViewDelegate?
    @IBOutlet var productCount: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productImg: UIImageView!
    let cartVM = CartViewModel()
    var productId:String?
    override func awakeFromNib() {
        super.awakeFromNib()
        productImg.layer.cornerRadius = 20
    }

 
    
    @IBAction func decrementProductNumber(_ sender: Any) {
        var count = Int(productCount.text ?? "1")
        if count ?? 1 > 1 {
            count!-=1
        }
        productCount.text = String(count ?? 1)
        if let productId = productId{
            updateProduct(id: productId, count: String(count  ?? 1))
        }
        cartDelegate?.updateCartTable()
    }
    @IBAction func incrementProductNumber(_ sender: Any) {
        var count = Int(productCount.text ?? "1")
            count!+=1
        productCount.text = String(count ?? 1)
        if let productId = productId{
            updateProduct(id: productId, count: String(count  ?? 1))
        }
        cartDelegate?.updateCartTable()
    }
    
    func updateProduct(id:String , count:String){
        cartVM.updateProduct(id: id, count: count)
    }
    
}

protocol cartViewDelegate{
    func updateCartTable()
}

