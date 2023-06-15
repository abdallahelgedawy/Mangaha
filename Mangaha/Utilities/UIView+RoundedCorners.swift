//
//  UIView+RoundedCorners.swift
//  Mangaha
//
//  Created by ME on 07/06/2023.
//

import Foundation
import UIKit
extension UIView{
    func changeCornerRadius(corner: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}

