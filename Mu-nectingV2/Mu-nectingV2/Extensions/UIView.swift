//
//  UIView.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 7/22/24.
//

import Foundation
import UIKit

extension UIView {
    func roundTopCorners(radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: radius, height: radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}
