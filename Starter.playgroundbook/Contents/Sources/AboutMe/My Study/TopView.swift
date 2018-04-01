//
//  TopView.swift
//  AboutMe-3
//
//  Created by Hao Dong on 17/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit

class TopView: UIView {
    override func draw(_ rect: CGRect) {
        let berize = UIBezierPath(arcCenter: CGPoint(x: self.center.x, y: self.center.y - 800), radius: 830, startAngle: 1, endAngle: 20, clockwise: true)
        let color = #colorLiteral(red: 0.6078431373, green: 0.7019607843, blue: 0.9215686275, alpha: 1)
        color.setFill()
        berize.fill()
    }
}
