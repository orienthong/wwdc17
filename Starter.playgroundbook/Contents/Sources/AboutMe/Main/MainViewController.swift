//
//  MainViewController.swift
//  AboutMe-3
//
//  Created by Hao Dong on 18/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit

public class MainViewController: UIViewController {
    
    
    var button: CustomButton!
    
    
    var firstButton: CustomButton!
    var secondButton: CustomButton!
    var thirdButton: CustomButton!
    var forthButton: CustomButton!
    
    var firstStackView: UIStackView!
    var secondStackView: UIStackView!
    var stackView: UIStackView!
    
    //let ZoomTransition = TransitionZoom()
    
    // thirdVC
    var visualEffectView = UIVisualEffectView()
    var animationProperty = UIViewPropertyAnimator()
    //var isPresenting = true
    var collectionView: UICollectionView!
    var backgroundView: UIView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUpBackgroundView()
        setUpButtons()
        setUpVisualEffectView()
        
    }
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutStackView()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setUpVisualEffectView() {
        // if visualView not present, isUserInteractionEnabled is false
        visualEffectView.isUserInteractionEnabled = false
        
        let visualViewTappedGesture = UITapGestureRecognizer(target: self, action: #selector(visualViewTapped(_:)))
        visualEffectView.addGestureRecognizer(visualViewTappedGesture)
        view.addSubview(visualEffectView)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    func setUpBackgroundView() {
        backgroundView = UIView()
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 1).isActive = true
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        backgroundView.layer.masksToBounds = false
        backgroundView.layer.shadowOpacity = 0.5
        backgroundView.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 10, height: 10)
        backgroundView.layer.shadowRadius = 20
    }
    func setUpButtons() {
        firstStackView = UIStackView()
        secondStackView = UIStackView()
        stackView = UIStackView()
        
        firstStackView.axis = .horizontal
        secondStackView.axis = .horizontal
        firstStackView.alignment = .fill
        firstStackView.distribution = .fillEqually
        firstStackView.spacing = 10
        secondStackView.alignment = .fill
        secondStackView.distribution = .fillEqually
        secondStackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(firstStackView)
        stackView.addArrangedSubview(secondStackView)
        
        backgroundView.addSubview(stackView)
        
        firstButton = CustomButton(type: .custom)
        firstButton.setImage(UIImage(named: "12753005,1440,900.jpg"), for: .normal)
        firstButton.textLabel.text = "My Study"
        firstButton.addTarget(self, action: #selector(firstButtonTapped(_:)), for: .touchUpInside)
        firstStackView.addArrangedSubview(firstButton)
        
        secondButton = CustomButton(type: .custom)
        secondButton.setImage(UIImage(named: "12518366,1440,900.jpg"), for: .normal)
        secondButton.textLabel.text = "My Location"
        secondButton.addTarget(self, action: #selector(secondButtonTapped(_:)), for: .touchUpInside)
        firstStackView.addArrangedSubview(secondButton)
        
        thirdButton = CustomButton(type: .custom)
        thirdButton.setImage(UIImage(named: "IMG_5340.png"), for: .normal)
        thirdButton.textLabel.text = "My Working"
        thirdButton.addTarget(self, action: #selector(thirdButtonTapped(_:)), for: .touchUpInside)
        secondStackView.addArrangedSubview(thirdButton)
        
        
        forthButton = CustomButton(type: .custom)
        forthButton.setImage(UIImage(named: "IMG_4191.png"), for: .normal)
        forthButton.textLabel.text = "Feature"
        secondStackView.addArrangedSubview(forthButton)
        forthButton.addTarget(self, action: #selector(forthButtonTapped(_:)), for: .touchUpInside)
        layoutStackView()
    }
    
    func layoutStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: stackView.heightAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func firstButtonTapped(_ sender: UIButton!) {
        //        firstButton.layer.cornerRadius = firstButton.frame.width / 2.0
        let svc = MyStudyVC()
        svc.modalTransitionStyle = .coverVertical
        self.present(svc, animated: true, completion: nil)
    }
    
    func secondButtonTapped(_ sender: UIButton!) {
        let svc = UINavigationController(rootViewController: MapVC())
        svc.modalTransitionStyle = .coverVertical
        self.present(svc, animated: true, completion: nil)
    }
    
    func forthButtonTapped(_ sender: UIButton!) {
        let vc = MyFeatureVC()
        vc.modalTransitionStyle = .flipHorizontal
        self.present(vc, animated: true, completion: nil)
    }
}
