//
//  FavoriteCollectionViewCell.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 07/06/2023.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        myFavBtn.layer.cornerRadius = 10
    }

    @IBOutlet weak var myFavBtn: UIButton!
    @IBAction func favBtn(_ sender: UIButton) {
        print("Favorite")
    }
    @IBOutlet weak var favImage: UIImageView!
}
