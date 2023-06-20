//
//  FinalOrderCell.swift
//  Mangaha
//
//  Created by ME on 20/06/2023.
//

import UIKit

class FinalOrderCell: UITableViewCell {

    @IBOutlet var productTotalPrice: UILabel!
    @IBOutlet var productQuantity: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
