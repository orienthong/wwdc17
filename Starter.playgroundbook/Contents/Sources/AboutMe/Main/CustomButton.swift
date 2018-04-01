//
//  CustomButton.swift
//  AboutMe-3
//
//  Created by Hao Dong on 18/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit
class CustomButton: UIButton {
    
    var colorFilter: UIView!
    var textLabel: UILabel!
    private var animationProperty: UIViewPropertyAnimator!
    
    override init(frame: CGRect) {
        textLabel = UILabel()
        animationProperty = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut, animations: nil)
        colorFilter = UIView()
        super.init(frame: frame)
        self.addSubview(colorFilter)
        colorFilter.isUserInteractionEnabled = false
        colorFilter.alpha = 0.4
        colorFilter.translatesAutoresizingMaskIntoConstraints = false
        colorFilter.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        colorFilter.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        colorFilter.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        colorFilter.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.addSubview(textLabel)
        textLabel.isUserInteractionEnabled = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textLabel.font = UIFont.boldSystemFont(ofSize: 20)
        textLabel.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //self.layer.cornerRadius = 10
        //self.layer.masksToBounds = true
        configureButton()
    }
    private func configureButton() {
        self.adjustsImageWhenHighlighted = false
        self.imageView?.contentMode = .scaleAspectFill
        self.colorFilter.backgroundColor = #colorLiteral(red: 0.4118889727, green: 0.5628422499, blue: 0.02126382134, alpha: 0.3510273973)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animationProperty.addAnimations {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        //        animationProperty.addCompletion { (position) in
        //            UIView.animate(withDuration: 0.5, animations: {
        //                self.transform = .identity
        //            })
        //        }
        animationProperty.startAnimation()
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = .identity
        })
        super.touchesEnded(touches, with: event)
    }
    
    
}
