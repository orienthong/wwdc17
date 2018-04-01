
//
//  Extensions.swift
//  AboutMe-3
//
//  Created by Hao Dong on 17/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit

extension UITextView {
    
    func animate(newText: String, characterDelay: TimeInterval) {
        
        DispatchQueue.main.async {
            
            self.text = ""
            
            for (index, character) in newText.characters.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
                    self.text?.append(character)
                }
            }
        }
    }
    
}
