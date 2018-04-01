//
//  ForthViewController.swift
//  AboutMe-3
//
//  Created by Hao Dong on 18/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit

class ForthViewController: MasterViewController {
    
    var imageView: UIImageView!
    var back: CustomBackButton!
    var flag = 0
    
    var animator: UIDynamicAnimator!
    let gravity = UIGravityBehavior()
    let collision = UICollisionBehavior()
    
    var labels = [UILabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visualEffectView.isUserInteractionEnabled = false
        setUpViews()
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity.gravityDirection = CGVector(dx: 0, dy: 0.8)
        animator.addBehavior(gravity)
        collision.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsets(top: 0, left: 0, bottom: view.frame.height/4, right: 0))
        //collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collision.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsets(top: 0, left: 0, bottom: view.frame.height/4, right: 0))
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func setUpTextView() {
        slideView.textView!.text = "I watched WWDC live video last year, and I knowed about Swift language.I was attacted by this programming language. During learning iOS Programming, I read many books writen in English from Ray and blogs from Medium. And I learned many new stuffs that I haven't learned before. Thanks, Swift.It really opens my eyes on learning Computer Sceince."
        slideView.textView!.font = UIFont(name: "Arial Rounded MT Bold", size: 23)
        slideView.sizeToFit()
    }
    
    func setUpViews() {
        imageView = UIImageView()
        imageView.image = UIImage(named: "IMG_4191.png")!
        view.insertSubview(imageView, belowSubview: visualEffectView)
        layoutViews(with: traitCollection.verticalSizeClass)
        setUpBackButton()
        
    }
    
    func layoutViews(with trait: UIUserInterfaceSizeClass) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        //        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 375/281.0).isActive = true
        switch trait {
        case .regular:
            imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        case .unspecified:
            fallthrough
        case .compact:
            imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        }
    }
    func setUpLabels() {
        addLabel(at: CGPoint(x: 30, y: 15), text: "MVVM", fontSize: 45,color: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))
        addLabel(at: CGPoint(x: 30, y: 20), text: "Server-Side-Swift", fontSize: 40,color: #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))
        addLabel(at: CGPoint(x: 40, y: 30), text: "Protocol Oriented Programming", fontSize: 25,color: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1))
        addLabel(at: CGPoint(x: 150, y: 40), text: "JavaScrip", fontSize: 41,color: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
        addLabel(at: CGPoint(x: 120, y: 35), text: "Protocol Buffers", fontSize: 33,color: #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1))
        addLabel(at: CGPoint(x: 170, y: 41), text: "Node.js", fontSize: 35,color: #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))
        addLabel(at: CGPoint(x: 100, y: 50), text: "Vapor", fontSize: 34,color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        back.frame = CGRect(x: view.center.x, y: 51, width: 100, height: 100)
        view.insertSubview(back, belowSubview: visualEffectView)
        gravity.addItem(back)
        collision.addItem(back)
        addLabel(at: CGPoint(x: 110, y: 42), text: "3D Graphics", fontSize: 36, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        addLabel(at: CGPoint(x: 111,y: 43), text: "HTML, CSS", fontSize: 37, color: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1))
        
    }
    func addLabel(at point: CGPoint, text: String, fontSize: CGFloat, color: UIColor) {
        let label = UILabel()
        view.insertSubview(label, belowSubview: imageView)
        label.text = text
        label.font = UIFont(name: "Arial Rounded MT Bold", size: fontSize)
        label.center = point
        label.sizeToFit()
        label.textColor = color
        gravity.addItem(label)
        collision.addItem(label)
        
        labels.append(label)
    }
    // remove all label so can animate again.
    func removeLables() {
        for label in labels {
            label.removeFromSuperview()
            //should remove Items
            gravity.removeItem(label)
            collision.removeItem(label)
        }
        //and we should also remove back button
        back.removeFromSuperview()
        gravity.removeItem(back)
        collision.removeItem(back)
    }
    
    func setUpBackButton() {
        back = CustomBackButton(type: .custom)
        back.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        back.setTitle("Back", for: .normal)
        back.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
    }
    func backButtonTapped(_ sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        let constraints = imageView.constraints
        imageView.removeConstraints(constraints)
        layoutViews(with: newCollection.verticalSizeClass)
        
        removeLables()
        setUpLabels()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func startAnimation() {
        super.startAnimation()
        UIView.transition(with: imageView, duration: 1.0, options: [.transitionCrossDissolve], animations: {
            self.imageView.image = (self.flag == 0) ? UIImage(named: "IMG_5340.png")! : UIImage(named: "IMG_4191.png")!
        }, completion: { finished in
            if finished {
                self.flag = (self.flag == 0) ? 1 : 0
                print(self.flag)
            }
        })
        setUpLabels()
        
    }
    
    
}
