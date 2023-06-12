//
//  CategoryCollectionViewCell.swift
//  Mangaha
//
//  Created by mariam adly on 08/06/2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(name : String,image:UIImage){
        self.categoryName.text = name
        self.categoryImg.image = image
    }

}
