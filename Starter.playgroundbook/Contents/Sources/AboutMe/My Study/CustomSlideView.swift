//
//  CustomSlideView.swift
//  AboutMe-3
//
//  Created by Hao Dong on 16/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit

class CustomSlideView: UIView {
    
    var slideButton: UIButton!
    var slideButtonDown: UIButton!
    var textView: UITextView!
    
    override init(frame: CGRect) {
        slideButton = UIButton(type: .custom)
        slideButtonDown = UIButton(type: .custom)
        textView = UITextView()
        super.init(frame: frame)
        
        self.addSubview(slideButton)
        slideButton.setTitle("", for: .normal)
        slideButton.setBackgroundImage(UIImage(named: "slideButtonUp.png"), for: .normal)
        slideButton.translatesAutoresizingMaskIntoConstraints = false
        slideButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        slideButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        self.addSubview(slideButtonDown)
        slideButtonDown.setTitle("", for: .normal)
        slideButtonDown.setImage(UIImage(named: "slideButtonDown.png"), for: .normal)
        slideButtonDown.translatesAutoresizingMaskIntoConstraints = false
        slideButtonDown.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        slideButtonDown.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        self.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        
        textView.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textView.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        textView.topAnchor.constraint(equalTo: slideButton.bottomAnchor, constant: 2).isActive = true
        textView.bottomAnchor.constraint(equalTo: slideButtonDown.topAnchor, constant: -2).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
