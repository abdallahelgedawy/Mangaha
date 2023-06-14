//
//  ProductCollectionViewCell.swift
//  Mangaha
//
//  Created by mariam adly on 08/06/2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    
    @IBOutlet weak var productPrice: UILabel!
    
   
    @IBOutlet weak var productCurrency: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        productView.layer.shadowOpacity = 0.3
        productView.layer.shadowRadius = 10
    }

    @IBAction func favoriteBtn(_ sender: Any) {
        
    }
    

}
