//
//  MasterViewController.swift
//  AboutMe-3
//
//  Created by Hao Dong on 16/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    enum SlideViewOperation : Int {
        case push
        case pop
    }
    var slideView: CustomSlideView!
    private var slidePropertyAnimator: UIViewPropertyAnimator!
    private var visualViewAnimator: UIViewPropertyAnimator!
    private var effect: UIVisualEffect!
    var visualEffectView: UIVisualEffectView!
    
    
    private var panRecognizer: UIPanGestureRecognizer!
    private var operation: SlideViewOperation = .push
    
    private var slideViewStartDragPosition: CGPoint!
    
    var topView: TopView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        visualEffectView = UIVisualEffectView(effect: nil)
        visualEffectView.frame = view.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(visualEffectView!)
        addSlideView()
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panSlideView(_:)))
        slideView.addGestureRecognizer(panRecognizer)
        
        effect = UIBlurEffect(style: .extraLight)
        visualViewAnimator = UIViewPropertyAnimator(duration: 0.8, curve: .easeOut, animations: {
            self.visualEffectView?.effect = self.effect
            self.slideView.slideButton.alpha = 0.0
            self.slideView.slideButtonDown.alpha = 1.0
        })
        setUpTopView()
        layoutTopView()
        topView.isHidden = true
        setUpTextView()
        
    }
    func setUpTextView() {
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateViewConstraints()
    }
    private func progress() -> CGFloat {
        switch operation {
        case .push :
            return abs(1 - (slideView.center.y - view.center.y) / view.center.y)
        case .pop :
            return abs((slideView.center.y - view.center.y) / view.center.y)
        }
    }
    
    func panSlideView(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            slideViewStartDragPosition = slideView.center
            operation = (slideViewStartDragPosition.y >= view.frame.maxY - view.frame.maxY / 20) ? .push : .pop
            switch operation {
            case .push:
                visualViewAnimator = UIViewPropertyAnimator(duration: 0.8, curve: .easeOut, animations: {
                    self.visualEffectView?.effect = self.effect
                    self.slideView.slideButton.alpha = 0.0
                    self.slideView.slideButtonDown.alpha = 1.0
                })
            case .pop:
                visualViewAnimator = UIViewPropertyAnimator(duration: 0.8, curve: .easeOut, animations: {
                    self.visualEffectView?.effect = nil
                    self.slideView.slideButton.alpha = 1.0
                    self.slideView.slideButtonDown.alpha = 0.0
                })
            }
        case .changed:
            let translation = sender.translation(in: view)
            slideView.center.y += translation.y
            let progress = self.progress()
            visualViewAnimator.fractionComplete = progress
            
            print(visualViewAnimator.fractionComplete)
            sender.setTranslation(CGPoint.zero, in: view)
        case .cancelled, .ended:
            endInteraction()
        default:
            break
        }
    }
    private func convert(_ velocity: CGPoint) -> CGVector {
        let dx = abs(view.center.x - slideView.center.x)
        let dy = abs(view.center.y - slideView.center.y)
        guard dx > 0.0 && dy > 0.0 else {
            return CGVector.zero
        }
        let range = CGFloat(35.0)
        let clippedVx = clip(-range, range, velocity.x / dx)
        let clippedVy = clip(-range, range, velocity.y / dy)
        return CGVector(dx: clippedVx, dy: clippedVy)
    }
    
    private func endInteraction() {
        let completionPosition = self.completionPosition()
        animate(completionPosition)
    }
    private func completionPosition() -> UIViewAnimatingPosition {
        let completionThreshold: CGFloat = 0.33
        let velocity = panRecognizer.velocity(in: view).toVector
        let isFlickDown = (velocity.dy > 0.0)
        let isFlickUp = (velocity.dy < 0.0)
        if (operation == .push && isFlickUp) || (operation == .pop && isFlickDown) {
            print("end1")
            return .end
        } else if (operation == .push && isFlickDown) || (operation == .pop && isFlickUp) {
            print("*********************")
            return .start
        } else if visualViewAnimator.fractionComplete > completionThreshold {
            print("end2")
            return .end
        } else {
            print("end3")
            return .start
        }
    }
    
    private func timingCurveVelocity() -> CGVector {
        // Convert the gesture recognizer's velocity into the initial velocity for the animation curve
        let gestureVelocity = panRecognizer.velocity(in: view)
        return convert(gestureVelocity)
    }
    
    private func animate(_ toPosition: UIViewAnimatingPosition) {
        let timingParameters = UISpringTimingParameters(mass: 4.5, stiffness: 1300, damping: 95, initialVelocity: timingCurveVelocity())
        slidePropertyAnimator = UIViewPropertyAnimator(duration: 0.8, timingParameters: timingParameters)
        slidePropertyAnimator.addAnimations {
            if self.operation == .push {
                self.slideView.center.y = (toPosition == .end ? self.view.center.y : self.view.frame.maxY)
            } else {
                self.slideView.center.y = (toPosition == .end ? self.view.frame.maxY : self.view.center.y)
            }
        }
        
        slidePropertyAnimator.startAnimation()
        
        visualViewAnimator.isReversed = (toPosition == .start)
        
        visualViewAnimator.addCompletion { (position) in
            if position == .end {
                print("end visualViewAnimator")
            }
            // fix the bug
            switch position {
            case .end:
                print("end visualViewAnimator")
            case .start:
                switch self.operation {
                case .push:
                    self.visualEffectView.effect = nil
                    self.slideView.slideButton.alpha = 1.0
                    self.slideView.slideButtonDown.alpha = 0.0
                case .pop:
                    self.visualEffectView.effect = self.effect
                    self.slideView.slideButton.alpha = 0.0
                    self.slideView.slideButtonDown.alpha = 1.0
                }
            default:
                break
            }
            
        }
        
        if visualViewAnimator.state == .inactive {
            //            print("inactive")
            //            print("\(operation)")
        } else {
            //            print("active")
            //            print("\(operation)")
            let durationFactor = CGFloat(slidePropertyAnimator.duration / visualViewAnimator.duration)
            visualViewAnimator.continueAnimation(withTimingParameters: nil, durationFactor: durationFactor)
        }
    }
    
    private func addSlideView() {
        slideView = CustomSlideView()
        view.addSubview(slideView)
        slideView.backgroundColor = #colorLiteral(red: 0.6507938504, green: 0.7373572588, blue: 0.9272412658, alpha: 1)
        slideView.translatesAutoresizingMaskIntoConstraints = false
        
        slideView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        slideView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        // 1/2 height
        slideView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
        // 1/2 out of main view
        slideView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height / 4).isActive = true
        slideView.isUserInteractionEnabled = true
    }
    private func layoutSlideView() {
        
    }
    private func setUpTopView() {
        topView = TopView()
        view.insertSubview(topView, belowSubview: visualEffectView!)
    }
    private func layoutTopView() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func startAnimation() {
        print(self)
    }
    
}
