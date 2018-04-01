//
//  PhotoFrame.swift
//  AboutMe-3
//
//  Created by Hao Dong on 20/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//


struct PhotoFrame {
    
    /// the frame Node name, used to custom tapGestureRecognizer
    var frameNode = [String]()
    
    /// the photo Index in materials
    var material = 0
    
    
    init(frameNode: [String]) {
        self.frameNode = frameNode
        
    }
}
