//
//  Unilit.swift
//  MazeGame
//
//  Created by Hao Dong on 28/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import Foundation
import SceneKit

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

extension float2 {
    init(_ v: CGPoint) {
        self.init(Float(v.x), Float(v.y))
    }
}

extension SCNTransaction {
    class func animateWithDuration(_ duration: CFTimeInterval = 0.25, timingFunction: CAMediaTimingFunction? = nil, completionBlock: (() -> Void)? = nil, animations: () -> Void) {
        begin()
        self.animationDuration = duration
        self.completionBlock = completionBlock
        self.animationTimingFunction = timingFunction
        animations()
        commit()
    }
}
