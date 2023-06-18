//
//  OnboardingCollectionViewCell.swift
//  Mangaha
//
//  Created by mariam adly on 15/06/2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var descriptionTxt: UILabel!
    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var slideImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(title : String , description : String, photo : UIImage){
        
        slideImage.image = photo
        titleTxt.text = title
        descriptionTxt.text = description
    }

}
