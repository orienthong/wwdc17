//
//  MyFeatureVC.swift
//  AboutMe-3
//
//  Created by Hao Dong on 02/04/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit
import PlaygroundSupport

class MyFeatureVC: MasterViewController, PlaygroundLiveViewSafeAreaContainer {
    
    var imageView: UIImageView!
    var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        imageView.image = UIImage(named: "IMG_4211.jpg")
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backButton.topAnchor.constraint(equalTo: liveViewSafeAreaGuide.topAnchor, constant: 20).isActive = true
    }
    override func setUpTextView() {
        slideView.textView.text = "That was Career Planning course, I got one chance to talk about the job as a iOS Developer. I talked about Swift Programming Language and many awesome development tools I used. I pretty love sharing and helping people. I made mistakes too. Last year, I read tons of blogs and many books but I didn’t spent much time in coding. So this year, I decide to get my hands dirty with code and learn design. I believe life begins at the end of your comfort zone. And at last, I want to thank Apple. Learning iOS Programming give me the ability to see the world and I will keep learning."
        slideView.textView.sizeToFit()
        
    }
    func setUpView() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        view.layer.masksToBounds = true
        view.insertSubview(imageView, belowSubview: visualEffectView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "Back.png"), for: .normal)
        view.insertSubview(backButton, belowSubview: visualEffectView)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        backButton.topAnchor.constraint(equalTo: liveViewSafeAreaGuide.topAnchor, constant: 20).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor, multiplier: 1).isActive = true
        visualEffectView.isUserInteractionEnabled = false
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
    }
    func backButtonTapped(_ sender: UIButton!) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
