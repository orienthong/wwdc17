//
//  CustomBackButton.swift
//  AboutMe-3
//
//  Created by Hao Dong on 18/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit
import QuartzCore

class CustomBackButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = 50
        self.layer.masksToBounds = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

