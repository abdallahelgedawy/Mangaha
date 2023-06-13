//
//  ReviewsCollectionViewCell.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 09/06/2023.
//

import UIKit

class ReviewsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var secondReviewLabel: UILabel!
    @IBOutlet weak var firstReviewLabel: UILabel!
    @IBOutlet weak var btn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        btn.layer.cornerRadius = 20
        
    }
      
    }


