//
//  GameMenuView.swift
//  MazeGame
//
//  Created by Hao Dong on 29/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit
import SceneKit

class GameMenuView: UIView {
    
    private var label: UILabel!
    var duraction: CFTimeInterval!
    var resetButton: UIButton!
    
    private var centerX: CGFloat!
    private var maxX: CGFloat!
    private var minX: CGFloat!
    private var num = 0
    override init(frame: CGRect) {
        label = UILabel()
        duraction = CFTimeInterval(3.0)
        resetButton = UIButton(type: .custom)
        super.init(frame: frame)
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -10).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.font = UIFont.systemFont(ofSize: 72)
        label.textColor = #colorLiteral(red: 0.6012416482, green: 0.5422363281, blue: 0.5395140052, alpha: 1)
        
        self.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        resetButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        resetButton.setImage(UIImage(named: "refresh.png"), for: .normal)
        resetButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        resetButton.widthAnchor.constraint(equalTo: resetButton.heightAnchor, multiplier: 1).isActive = true
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginTiming() {
        num = Int(duraction)
        centerX = self.center.x
        maxX = self.frame.maxX
        minX = self.frame.minX
        doNext()
    }
    private func animate() {
        self.label.text = "\(num)"
        self.label.center.y = center.y
        self.label.alpha = 0
        let animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut, animations: {
            UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.15, animations: {
                    self.label.center.x = self.centerX - 50
                    self.label.alpha = 0.3
                })
                UIView.addKeyframe(withRelativeStartTime: 0.15, relativeDuration: 0.35, animations: {
                    self.label.center.x = self.centerX - 25
                    self.label.alpha = 0.8
                })
                UIView.addKeyframe(withRelativeStartTime: 0.35, relativeDuration: 0.45, animations: {
                    self.label.center.x = self.centerX - 10
                    self.label.alpha = 0.9
                })
                UIView.addKeyframe(withRelativeStartTime: 0.45, relativeDuration: 0.5, animations: {
                    self.label.center.x = self.centerX
                    self.label.alpha = 1
                })
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.55, animations: {
                    self.label.center.x = self.centerX + 10
                    self.label.alpha = 0.9
                })
                UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.65, animations: {
                    self.label.center.x = self.centerX + 25
                    self.label.alpha = 0.8
                })
                UIView.addKeyframe(withRelativeStartTime: 0.65, relativeDuration: 0.75, animations: {
                    self.label.center.x = self.centerX + 50
                    self.label.alpha = 0.3
                })
                UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 1, animations: {
                    self.label.center.x = self.maxX + 10
                    self.label.alpha = 0
                })
                
            }, completion: { (finished) in
                if finished {
                    print(finished)
                    self.doNext()
                }
            })
        })
        animator.startAnimation()
    }
    
    func doNext() {
        guard num > 0 else {
            return
        }
        animate()
        num -= 1
    }
    
    
}
