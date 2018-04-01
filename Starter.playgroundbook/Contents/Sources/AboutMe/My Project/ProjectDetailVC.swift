//
//  ProjectDetailVC.swift
//  AboutMe-3
//
//  Created by Hao Dong on 27/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit
import QuartzCore

class ProjectDetailVC: UIViewController {
    
    var backgroundView: UIView!
    var imageView: UIImageView!
    var backButton: UIButton!
    
    var snapView: UIView!
    
    var cellIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setUpViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        imageView.alpha = 0.0
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.imageView.alpha = 1.0
        }, completion: nil)
        super.viewWillAppear(animated)
        
    }
    
    func setUpViews() {
        backgroundView = UIView()
        backgroundView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "IMG_5340.png")
        imageView.layer.masksToBounds = true
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 235).isActive = true
        
        
        backButton = UIButton(type: .custom)
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        backButton.setImage(UIImage(named: "CTA1.png"), for: .normal)
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 26).isActive = true
        backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    func backButtonTapped(_ sender: UIButton!) {
//        let snapView = imageView.snapshotView(afterScreenUpdates: true)!
//        let backgroundSnapView = backgroundView.snapshotView(afterScreenUpdates: true)!
//        let mainVC = presentingViewController as! MainViewController
//        let cell = mainVC.collectionView.cellForItem(at: cellIndexPath)! as! CustomCell
//        cell.contentView.alpha = 0.0
//        let cellRect = cell.convert(cell.bounds, to: mainVC.view)
//        print(cellRect)
//        let imageViewRect = cell.imageView.convert(cell.imageView.bounds, to: mainVC.view)
//        self.dismiss(animated: false, completion: nil)
//        snapView.frame = imageView.frame
//        backgroundSnapView.frame = backgroundView.frame
//        mainVC.view.addSubview(backgroundSnapView)
//        mainVC.view.addSubview(snapView)
//        snapView.layer.masksToBounds = false
////        UIView.animate(withDuration: 2.0, animations: {
////            //snapView.frame = imageViewRect
////            snapView.layer.frame = imageViewRect
////        })
//        let timing = UISpringTimingParameters(mass: 4.5, stiffness: 1300, damping: 95, initialVelocity: CGVector(dx: 0.5, dy: 0.5))
//        let animation = UIViewPropertyAnimator(duration: 2.0, timingParameters: timing)
//        animation.addAnimations {
//            cell.contentView.alpha = 1.0
//            snapView.alpha = 0.0
//            backgroundSnapView.alpha = 0.0
//        }
//        animation.addCompletion { (_) in
//            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
//                //snapView.alpha = 0.0
//            }, completion: { (_) in
//                //snapView.removeFromSuperview()
//            })
//        }
//        animation.startAnimation()
//        
        self.dismiss(animated: true, completion: nil)
    }
    
}
