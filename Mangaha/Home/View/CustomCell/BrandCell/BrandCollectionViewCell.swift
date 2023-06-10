//
//  BrandCollectionViewCell.swift
//  Mangaha
//
//  Created by mariam adly on 07/06/2023.
//

import UIKit

class BrandCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var brandView: UIView!
    @IBOutlet weak var brandName: UILabel!
    
    @IBOutlet weak var brandImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(name : String , image : UIImage){
        self.brandName.text = name
        self.brandImg.image = image
    }

}
