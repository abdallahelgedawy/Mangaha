//
//  AdressesCell.swift
//  Mangaha
//
//  Created by ME on 08/06/2023.
//

import UIKit

class AdressesCell: UITableViewCell {

    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var cellBuble: UIView!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var streetLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      //  setupCellUI()
    }

    func setupCellUI(){
      /* cellBuble.layer.borderWidth = 2
        cellBuble.layer.borderColor = UIColor(red: 38/255, green: 37/255, blue: 76/255, alpha: 1).cgColor*/
        cellBuble.changeCornerRadius(corner: [.topLeft , .topRight], radius: 20)
    }
    
}
