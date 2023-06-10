//
//  ProductCollectionViewCell.swift
//  Mangaha
//
//  Created by mariam adly on 08/06/2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var inStockLabel: UILabel!
    @IBOutlet weak var productCurrency: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func favoriteBtn(_ sender: Any) {
        
    }
    
    func setupCell(name:String,image:UIImage,price:Int,inStock:String,currency:String){
        self.productName.text = name
        self.productImg.image = image
        self.productPrice.text = String(price)
        self.inStockLabel.text = inStock
        self.productCurrency.text = currency
    }
}
