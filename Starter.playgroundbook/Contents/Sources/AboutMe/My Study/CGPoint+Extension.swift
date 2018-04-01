//
//  CGPoint+Extension.swift
//  AboutMe-3
//
//  Created by Hao Dong on 15/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import CoreGraphics

extension CGPoint {
    func distance(toPoint point: CGPoint) -> CGFloat {
        return sqrt((point.x - x) * (point.x - x) + (point.y - y) * (point.y - y))
    }
    
    func normalise(weight: CGFloat) -> CGPoint {
        return CGPoint(x: x / weight, y: y / weight)
    }
    
    var toVector: CGVector {
        return CGVector(dx: x, dy: y)
    }
    var vector: CGVector {
        return CGVector(dx: x, dy: y)
    }
}

extension CGVector {
    var magnitude: CGFloat {
        return sqrt(dx*dx + dy*dy)
    }
    
    var point: CGPoint {
        return CGPoint(x: dx, y: dy)
    }
    
    func apply(transform t: CGAffineTransform) -> CGVector {
        return point.applying(t).vector
    }
}

func clip<T : Comparable>(_ x0: T, _ x1: T, _ v: T) -> T {
    return max(x0, min(x1, v))
}


