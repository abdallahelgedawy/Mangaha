//
//  CustomBarButtom.swift
//  Mangaha
//
//  Created by ME on 20/06/2023.
//

import Foundation
import UIKit
class BadgeButton: UIButton {
    private var badgeLabel: UILabel?
   

    var badgeCount: Int = 0 {
        didSet {
            updateBadge()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBadge()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBadge()
    }

    private func setupBadge() {
      /* var buttonImage = UIImage(systemName: "cart.fill")
        setImage(buttonImage, for: .normal)*/
        let badgeSize = CGSize(width: 15, height: 15)
        let badgeOrigin = CGPoint(x: bounds.width - badgeSize.width + 45, y: 4)
        let badgeFrame = CGRect(origin: badgeOrigin, size: badgeSize)

        badgeLabel = UILabel(frame: badgeFrame)
        badgeLabel?.backgroundColor = .lightGray
        badgeLabel?.textColor = .white
        badgeLabel?.font = UIFont.systemFont(ofSize: 10)
        badgeLabel?.textAlignment = .center
        badgeLabel?.layer.cornerRadius = badgeSize.height / 2
        badgeLabel?.layer.masksToBounds = true

        addSubview(badgeLabel!)
        updateBadge()
    }

    private func updateBadge() {
        badgeLabel?.text = "\(badgeCount)"
        badgeLabel?.isHidden = badgeCount == 0
    }
}
