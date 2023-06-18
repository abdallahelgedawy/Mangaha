//
//  FavoriteCollectionViewCell.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 07/06/2023.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    var product :CartProduct?
      var index:Int?
    var delegate:CellDelegate?
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productTitle: UILabel!
    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var myFavBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        myFavBtn.layer.cornerRadius = 10
    }

    
    @IBAction func favBtn(_ sender: UIButton) {
        delegate?.deleteButtonPressed(cell: self, product?.id ?? "")
    }

    
}

protocol CellDelegate: AnyObject {
    func deleteButtonPressed(cell: UICollectionViewCell , _ id:String)
}
