//
//  ThirdViewController.swift
//  AboutMe-2
//
//  Created by Hao Dong on 13/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit
import SceneKit
import QuartzCore

class ThirdViewController: MasterViewController {
    
    var sceneView: SCNView!
    var scene: SCNScene!
    var rootNode: SCNNode!
    
    //configure design
    var font = UIFont(name: "Arial Rounded MT Bold", size: 50)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUp topView backgroundColor
        topView.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.5607843137, blue: 0, alpha: 1)
        scene = SCNScene()
        scene.background.contents = #colorLiteral(red: 0.1098039216, green: 0.5607843137, blue: 0, alpha: 1)
        addSceneView()
        setUpScene()
    }
    override func setUpTextView() {
        slideView.textView!.text = "When I came to college, I learned many  stuffs from my teachers and mentors. And I also joined a team and we created an Android app that help my schoolmates login in our school's public network.I though I had learned a lot but still not enough."
        slideView.textView!.font = UIFont(name: "Arial Rounded MT Bold", size: 25)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutSceneView()
    }
    
    private func addSceneView() {
        sceneView = SCNView()
        view.insertSubview(sceneView, belowSubview: topView)
        sceneView.scene = scene
        sceneView.allowsCameraControl = false
        rootNode = scene.rootNode
    }
    private func layoutSceneView() {
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sceneView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    private func setUpScene() {
        placeItems(with: "Java", atPoint: CGPoint(x: -5, y: 2), timeOffset: 0)
        placeItems(with: "Android", atPoint: CGPoint(x: -4.3, y: 6), timeOffset: 0.05)
        placeItems(with: "Object", atPoint: CGPoint(x: -6, y: 5), timeOffset: 0.1)
        placeItems(with: "Class", atPoint: CGPoint(x: -2, y: 4), timeOffset: 0.15)
        placeItems(with: "MVC", atPoint: CGPoint(x: -3, y: 1), timeOffset: 0.2)
        placeItems(with: "Framework", atPoint: CGPoint(x: -4, y: 8), timeOffset: 0.35)
        placeItems(with: "Github", atPoint: CGPoint(x: -2, y: 3), timeOffset: 0.5)
    }
    
    func placeItems(with name: String,atPoint point: CGPoint, timeOffset offset: CGFloat) {
        let text = SCNText(string: name, extrusionDepth: 5)
        text.font = font
        text.flatness = 0.4
        text.firstMaterial?.diffuse.contents = UIColor.white
        
        let textNode = SCNNode()
        textNode.geometry = text
        textNode.position = SCNVector3Make(Float(point.x), Float(point.y), 0)
        textNode.scale = SCNVector3Make(0.02, 0.02, 0.02)
        // add node
        rootNode.addChildNode(textNode)
        
        //Animation here
        let positionAnimation = CABasicAnimation(keyPath: "position.z")
        positionAnimation.fromValue = -10
        positionAnimation.toValue = 5
        positionAnimation.duration = 5.0
        positionAnimation.timeOffset = positionAnimation.duration.multiplied(by: Double(offset))
        positionAnimation.repeatCount = .greatestFiniteMagnitude
        textNode.addAnimation(positionAnimation, forKey: nil)
        
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.keyTimes = [0.0, 0.2, 0.5, 0.7, 1.0]
        opacityAnimation.values = [0.0, 1.0, 0.8, 0.0, 0.0]
        opacityAnimation.duration = positionAnimation.duration
        opacityAnimation.timeOffset = positionAnimation.timeOffset
        opacityAnimation.repeatCount = .greatestFiniteMagnitude
        textNode.addAnimation(opacityAnimation, forKey: nil)
        
        
    }
    
    
}
