//
//  MyProject.swift
//  AboutMe-3
//
//  Created by Hao Dong on 26/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit

public extension MainViewController {
    func thirdButtonTapped(_ sender: UIButton!) {
        addCollectionView()
        
        animationProperty = UIViewPropertyAnimator(duration: 0.8, curve: .easeOut, animations: {
            let effect = UIBlurEffect(style: .dark)
            self.visualEffectView.effect = effect
            //self.collectionView.alpha = 1.0
        })
        animationProperty.addCompletion { _ in
            let timing = UISpringTimingParameters(mass: 4.5, stiffness: 1300, damping: 95, initialVelocity: CGVector(dx: 0.5, dy: 0.5))
            let animation = UIViewPropertyAnimator(duration: 0.4, timingParameters: timing)
            animation.addAnimations {
                self.collectionView.alpha = 1.0
                self.collectionView.transform = .identity
            }
            animation.startAnimation()
            self.visualEffectView.isUserInteractionEnabled = true
        }
        animationProperty.startAnimation()
    }
    func visualViewTapped(_ sender: UITapGestureRecognizer) {
        //print("abcdefg")
        animationProperty = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut, animations: {
            
            //self.collectionView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            self.collectionView.alpha = 0.0
            self.collectionView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            //self.visualEffectView.effect = nil
        })
        animationProperty.addCompletion { (position) in
            let animation = UIViewPropertyAnimator(duration: 0.8, curve: .easeOut, animations: {
                self.visualEffectView.effect = nil
            })
            animation.startAnimation()
            self.collectionView.removeFromSuperview()
            self.visualEffectView.isUserInteractionEnabled = false
            
        }
        animationProperty.startAnimation()
    }
    func addCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.itemSize = CGSize(width: 300, height: 304)
        layout.minimumLineSpacing = 30
        //CGRect(x: view.frame.midX - 120, y: 80, width: 240, height: view.frame.height)
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "Cell")
        //let nib = UINib(nibName: "Cell", bundle: nil)
        //let nibb = nib.instantiate(withOwner: nil, options: nil)
        //let celll = nibb.first as! CustomCollectionViewCell
        //let nibArray = nib.instantiate(withOwner: nil, options: nil)
        //let celll = nibArray.first as! CustomCollectionViewCell
        //collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isUserInteractionEnabled = true
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.0)
        collectionView.layer.masksToBounds = false
        collectionView.showsVerticalScrollIndicator = false

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        
        //use for animation
        collectionView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        collectionView.alpha = 0.0
    }
}
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
}

extension MainViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCell
        if indexPath.item == 0 {
            cell.imageView.image = UIImage(named: "MyBlog.png")
            cell.textView.text = "'scauos.github.io' is my blog website. I post some of my blogs here to share my knowledge. "
        } else if indexPath.item == 1 {
            cell.imageView.image = UIImage(named: "PhotoFrame.png")
            cell.textView.text = "PhotoFrame is my currently working on project. I have designed this app, and started programming right now. It will be released in several monthes."
        }
        
        return cell
    }
}
extension MainViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("selected")
//        let cell = collectionView.cellForItem(at: indexPath) as! CustomCell
//        let backgroundView = cell.backgroundView!
//        let backgroundSnapView = backgroundView.snapshotView(afterScreenUpdates: true)!
//        let backgroundViewRect = backgroundView.convert(backgroundView.bounds, to: view)
//        view.addSubview(backgroundSnapView)
//        backgroundSnapView.frame = backgroundViewRect
//        let snapView = cell.imageView.snapshotView(afterScreenUpdates: true)!
//        view.addSubview(snapView)
//        let rect = cell.imageView.convert(cell.imageView.bounds, to: view)
//        snapView.frame = rect
//        let timing = UISpringTimingParameters(mass: 4.5, stiffness: 1300, damping: 95, initialVelocity: CGVector(dx: 0.5, dy: 0.5))
//        let animationProperty = UIViewPropertyAnimator(duration: 0.6, timingParameters: timing)
//        animationProperty.addAnimations {
//            backgroundSnapView.frame = self.view.frame
//            snapView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 235)
//        }
//        animationProperty.addCompletion { (_) in
//            let animation = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut, animations: {
//                snapView.alpha = 0.0
//                
//            })
//            animation.addCompletion({ (_) in
//                backgroundSnapView.removeFromSuperview()
//                snapView.removeFromSuperview()
//            })
//            let vc = ProjectDetailVC()
//            vc.cellIndexPath = indexPath
//            vc.modalTransitionStyle = .crossDissolve
//            self.present(vc, animated: false, completion: nil)
//            animation.startAnimation()
//        }
//        
//        animationProperty.startAnimation()
//        
    }
}
