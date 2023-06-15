//
//  CartCell.swift
//  Mangaha
//
//  Created by ME on 08/06/2023.
//

import UIKit

class CartCell: UITableViewCell {

    @IBOutlet var productCount: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        productImg.layer.cornerRadius = 20
    }

 
    
    @IBAction func decrementProductNumber(_ sender: Any) {
        
    }
    @IBAction func incrementProductNumber(_ sender: Any) {
    }
}
