//
//  Dispatch.swift
//  PlayParticles
//
//  Created by Hao Dong on 11/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import Foundation

public func delay(delay:Double, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
