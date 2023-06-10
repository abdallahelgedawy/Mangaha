//
//  ReviewsCollectionViewCell.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 09/06/2023.
//

import UIKit

class ReviewsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var secondReviewLabel: UILabel!
    @IBOutlet weak var sizesBtn: UIButton!
    @IBOutlet weak var firstReviewLabel: UILabel!
    @IBOutlet weak var btn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        btn.layer.cornerRadius = 20
        sizesBtn.menu = UIMenu(
            title: "Options",
            options: .singleSelection,
            children: [
                UIAction(title: "Option 1", handler: { action in
                    // Handle Option 1 selection
                    print("Option 1 selected")
                }),
                UIAction(title: "Option 2", handler: { action in
                    // Handle Option 2 selection
                    print("Option 2 selected")
                }),
                UIAction(title: "Option 3", handler: { action in
                    // Handle Option 3 selection
                    print("Option 3 selected")
                })
            ]
        )
    }
      
    }


