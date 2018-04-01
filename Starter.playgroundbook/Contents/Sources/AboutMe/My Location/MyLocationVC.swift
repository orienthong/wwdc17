//
//  MyLocationVC.swift
//  AboutMe-3
//
//  Created by Hao Dong on 19/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit
enum MyLocation: String {
    case Beijing
    case Guangzhou
}
class MyLocationVC: UIViewController {
    
    //property goes here
    var imageView: UIImageView!
    var label: UILabel!
    var bottomView: BottomView!
    var backButton: UIButton!
    var pageControl: UIPageControl!
    
    var location: MyLocation = .Guangzhou
    
    
    /// 0: GuangZhou, 1: SCAU, 2: Desk
    var flag = 0
    
    let guangzhou = "Hello, I am located in GuangZhou, China.It is a big city in the south of China.  I came to GuangZhou because I study here, my collage is located in GuangZhou. Rectenly, GuangZhou is rainy, I love this kind of weather. "
    let scau = "SCAU, is my collage. I majoy in Computer Science in my school. Although my teachers didn't teach me iOS Programming, but I can learn some awesome stuff from our teachers. I love this collage."
    let myDesk = "This is my desk in my dormitory, I spent most of my time learning iOS Programming here. The warm color light make me feel comfortable. The toy standing there remind me 'Don't Give Up!' I love my desk."
    let iDev = "I attended iDev last year. It's a convention teaching iOS Programming. I received a Student ticket. The most excited thing is I learned Server-Side Swift. I also meet many persons who are the iOS leader of some famous company. We together had lunch that day."
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //add gestureRecognizer
        switch location {
        case .Beijing:
            break
        case .Guangzhou:
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
            swipeGesture.direction = .left
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(swipeGesture)
            let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
            swipeGestureRight.direction = .right
            imageView.addGestureRecognizer(swipeGestureRight)
        }
        imageView.layer.masksToBounds = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func dismissTransition(_ sender: UISwipeGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func swipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            self.flag = (self.flag + 1) % 3
        } else {
            self.flag = self.flag - 1
            self.flag = (self.flag == -1) ? 2 : self.flag
        }
        self.pageControl.currentPage = self.flag
        UIView.transition(with: imageView, duration: 0.8, options: .transitionCrossDissolve, animations: {
            switch self.flag {
            case 0:
                self.imageView.image = UIImage(named: "12518366,1440,900.jpg")
                self.bottomView.textView.text = self.guangzhou
                self.label.text = "Guangzhou"
            case 1:
                self.imageView.image = UIImage(named: "SCAU.jpg")
                self.bottomView.textView.text = self.scau
                self.label.text = "SCAU"
            default:
                self.imageView.image = UIImage(named: "IMG_4234.JPG")
                self.bottomView.textView.text = self.myDesk
                self.label.text = "My Desk"
            }
        }, completion: nil)
    }
    
    
    
    func setUpViews() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        layoutImageView()
        
        label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 40)
        view.addSubview(label)
        layoutLabel()
        
        bottomView = BottomView()
        let textView = bottomView.textView
        bottomView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(bottomView)
        layoutBottomView()
        
        pageControl = UIPageControl()
        layoutPageControl()
        
        switch location {
        case .Beijing:
            imageView.image = UIImage(named: "iDev.png")
            label.text = "Beijing"
            textView?.text = iDev
            textView?.font = UIFont(name: "Arial Rounded MT Bold", size: 16)
            pageControl.isHidden = true
        default:
            imageView.image = UIImage(named: "12518366,1440,900.jpg")
            label.text = "Guangzhou"
            textView?.text = guangzhou
            pageControl.numberOfPages = 3
        }
        
    }
    func layoutImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    func layoutBottomView() {
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
    }
    func layoutLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive =  true
        label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        
    }
    func layoutPageControl() {
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: label.topAnchor, constant: 0).isActive = true
        
    }
    
    
}
