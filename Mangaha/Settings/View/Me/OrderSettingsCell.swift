//
//  OrderSettingsCell.swift
//  Mangaha
//
//  Created by ME on 07/06/2023.
//

import UIKit

class OrderSettingsCell: UITableViewCell {

    @IBOutlet var cellBuble: UIView!
    @IBOutlet var orderPriceLabel: UILabel!
    @IBOutlet var orderDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
    }

    func setupCellUI(){
        cellBuble.layer.borderWidth = 2
        cellBuble.layer.borderColor = UIColor(red: 238/255, green: 61/255, blue: 64/255, alpha: 1).cgColor
        cellBuble.layer.cornerRadius = 20
        cellBuble.clipsToBounds = true
    }
}
