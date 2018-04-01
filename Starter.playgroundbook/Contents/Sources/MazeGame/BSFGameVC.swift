//
//  BSFGameVC.swift
//  MazeGame
//
//  Created by Hao Dong on 31/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import SceneKit
import UIKit
import PlaygroundSupport

public class BSFGameVC: UIViewController, PlaygroundLiveViewSafeAreaContainer {
    let helper = GameHelper()
    var sceneView: SCNView!
    var scene: SCNScene!
    var position: SCNVector3? = nil
    
    var entrence: Location = Location(z: 14, x: 0)
    var endPoint = Location(z: 0, x: 12)
    
    var sphereNode = SCNNode()
    
    var cameraButton: UIButton!
    
    internal var panningTouch: UITouch?
    var cameraYHandle = SCNNode()
    var cameraXHandle = SCNNode()
    var cameraNode = SCNNode()
    
    var isLocked = true
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        scene = SCNScene(named: "art.scnassets/MazeGame_3.scn")
        setUpView()
        sphereNode = scene.rootNode.childNode(withName: "sphere", recursively: true)!
        sceneView.scene = scene
        scene.lightingEnvironment.contents = UIImage(named: "img_skybox.jpg")
        
        scene.background.contents = UIImage(named: "img_skybox.jpg")
        positionBoxs()
        animateSphere()
        configureCamera()
        
    }
    
    let matrix = [[0,0,0,1,0,0,1,0,0,0,0,1,0,1,0],
                  [0,1,0,1,0,1,1,1,1,0,0,1,0,1,0],
                  [0,1,0,0,0,0,0,0,1,0,1,1,0,1,1],
                  [1,1,1,0,1,1,1,0,1,0,0,0,0,0,0],
                  [0,0,0,0,0,1,0,0,1,1,1,1,0,1,0],
                  [1,0,1,1,0,0,1,0,1,0,0,0,0,1,0],
                  [0,0,1,0,0,1,1,1,1,0,1,0,0,1,0],
                  [1,0,1,0,0,0,1,0,1,1,1,0,1,1,1],
                  [1,0,1,0,1,0,1,0,0,0,1,0,0,0,0],
                  [1,0,1,1,1,0,1,1,0,1,0,0,1,1,0],
                  [0,0,0,1,1,0,0,0,0,1,1,1,0,0,0],
                  [1,1,0,1,0,0,1,0,0,0,0,1,1,1,0],
                  [0,0,0,1,1,1,1,1,1,0,0,0,0,1,0],
                  [0,1,0,1,0,0,0,0,1,0,1,1,0,0,0],
                  [0,1,0,0,0,1,0,1,0,0,0,0,0,0,0]]
    
    
    
    func setUpView() {
        sceneView = SCNView()
        cameraButton = UIButton(type: .custom)
        view.addSubview(sceneView)
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sceneView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //        cameraButton.setTitle("Camera", for: .normal)
        cameraButton.setImage(UIImage(named: "camera.png"), for: .normal)
        sceneView.addSubview(cameraButton)
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.trailingAnchor.constraint(equalTo: liveViewSafeAreaGuide.trailingAnchor, constant: -20).isActive = true
        cameraButton.topAnchor.constraint(equalTo: liveViewSafeAreaGuide.topAnchor, constant: 20).isActive = true
        cameraButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cameraButton.heightAnchor.constraint(equalTo: cameraButton.widthAnchor, multiplier: 1).isActive = true
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped(_:)), for: .touchUpInside)
        
        
    }
    func positionBoxs() {
        let box = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.1)
        box.firstMaterial?.lightingModel = .physicallyBased
        box.firstMaterial?.metalness.contents = UIImage(named: "gold-scuffed-metal.png")
        box.firstMaterial?.normal.contents = UIImage(named: "gold-scuffed-normal.png")
        box.firstMaterial?.roughness.contents = UIImage(named: "gold-scuffed-roughness.png")
        //box.firstMaterial?.diffuse.contents = UIImage(named: "203843.jpg")
        for z in 0 ... matrix.count-1 {
            for x in 0 ... matrix[0].count-1 {
                let zPosition = Float(z - matrix.count/2)
                let xPosition = Float(x - matrix.count/2)
                if matrix[z][x] == 1 {
                    let boxNode = SCNNode()
                    boxNode.name = "boxs"
                    boxNode.geometry = box
                    position = SCNVector3Make(xPosition, 0.5, zPosition)
                    scene.rootNode.addChildNode(boxNode)
                    boxNode.position = position!
                    
                } else {
                    position = nil
                    //print(position)
                }
            }
            
        }
    }
    func animateSphere() {
        if entrence.x >= 0 && entrence.x <= 14 && entrence.z >= 0 && entrence.z <= 14 && endPoint.x >= 0 && endPoint.x <= 14 && endPoint.z >= 0 && endPoint.z <= 14 {
            sphereNode.removeAllActions()
            sphereNode.position = SCNVector3Make(Float(entrence.x-7), 0.5, Float(entrence.z-7))
            //let cameraNode = scene.rootNode.childNode(withName: "camera", recursively: true)!
            if let directions = helper.Check(with: matrix, startPoint: entrence, endPoint: endPoint) {
                print(directions)
                let action = helper.getActions(with: directions.getLast())
                sphereNode.runAction(SCNAction.repeatForever(action), forKey: "sphere")
            }
        }
    }
    func cameraButtonTapped(_ sender: UIButton!) {
        //
        print("abc")
        if isLocked { //top view
            cameraButton.isEnabled = false
            SCNTransaction.animateWithDuration(2.0, timingFunction: nil, completionBlock: {
                if let action = self.sphereNode.action(forKey: "sphere") {
                    self.cameraYHandle.runAction(action, forKey: "camera")
                    self.cameraButton.isEnabled = true
                }
            }, animations: {
                cameraYHandle.position = SCNVector3Make(Float(entrence.x-7), 0.5, Float(entrence.z-7))
                cameraYHandle.eulerAngles = SCNVector3Zero
            })
            
            isLocked = false
        } else {
            cameraButton.isEnabled = false
            cameraYHandle.removeAction(forKey: "camera")
            SCNTransaction.animateWithDuration(2.0, timingFunction: nil, completionBlock: {
                self.cameraButton.isEnabled = true
            }, animations: {
                cameraYHandle.position = SCNVector3Make(0, 40, 0)
                cameraYHandle.eulerAngles = SCNVector3Make(Float(-90).degreesToRadians, 0, 0)
                cameraXHandle.position = SCNVector3Zero
                cameraXHandle.eulerAngles = SCNVector3Zero
                cameraNode.position = SCNVector3Zero
                cameraNode.eulerAngles = SCNVector3Zero
            })
            isLocked = true
        }
    }
    
    func configureCamera() {
        cameraNode = scene.rootNode.childNode(withName: "camera", recursively: true)!
        cameraNode.camera?.zFar = 100
        cameraNode.camera?.zNear = 0.3
        cameraNode.camera?.motionBlurIntensity = 0.5
        scene.rootNode.addChildNode(cameraYHandle)
        cameraYHandle.position = SCNVector3Make(0, 40, 0)
        cameraYHandle.eulerAngles = SCNVector3Make(Float(-90).degreesToRadians, 0, 0)
        cameraYHandle.addChildNode(cameraXHandle)
        cameraXHandle.position = SCNVector3Zero
        cameraXHandle.eulerAngles = SCNVector3Zero
        
        cameraXHandle.addChildNode(cameraNode)
        cameraNode.position = SCNVector3Zero
        cameraNode.eulerAngles = SCNVector3Zero
    }
    // MARK: Managing camera
    func panCamera(_ direction: float2) {
        if isLocked {
            return
        }
        var directionToPan = direction
        directionToPan *= float2(1.0, -1.0)
        let F = SCNFloat(0.005)
        SCNTransaction.animateWithDuration(0.0) {
            //self.cameraYHandle.removeAllActions()
            //self.cameraXHandle.removeAllActions()
            
            if self.cameraYHandle.rotation.y < 0 {
                self.cameraYHandle.rotation = SCNVector4(0, 1, 0, -self.cameraYHandle.rotation.w)
            }
            
            if self.cameraXHandle.rotation.x < 0 {
                self.cameraXHandle.rotation = SCNVector4(1, 0, 0, -self.cameraXHandle.rotation.w)
            }
            
        }
        // Update the camera position with some inertia.
        
        SCNTransaction.animateWithDuration(0.5, timingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)) {
            self.cameraYHandle.rotation = SCNVector4(0, 1, 0, self.cameraYHandle.rotation.y * (self.cameraYHandle.rotation.w - SCNFloat(directionToPan.x) * F))
            self.cameraXHandle.rotation = SCNVector4(1, 0, 0, min(max(self.cameraXHandle.rotation.w + SCNFloat(directionToPan.y) * F, 5.5), 7.0))
            print("\(self.cameraYHandle.rotation)**\(self.cameraXHandle.rotation)")
        }
        
    }
    // MARK: Touch Events
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        panningTouch = touches.first
    }
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = panningTouch {
            let displacement = (float2(touch.location(in: sceneView)) - float2(touch.previousLocation(in: sceneView)))
            print(displacement)
            panCamera(displacement)
        }
    }
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        panningTouch = nil
    }
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        panningTouch = nil
    }
}
extension BSFGameVC: PlaygroundLiveViewMessageHandler {
    public func receive(_ message: PlaygroundValue) {
        switch message {
        case let .dictionary(dir):
            if case let .array(arr)? = dir["entrence"] {
                guard case let .integer(z) = arr[0], case let .integer(x) = arr[1] else {
                    return
                }
                entrence = Location(z: z, x: x)
            } else if case let .array(arr)? = dir["endPoint"] {
                guard case let .integer(z) = arr[0], case let .integer(x) = arr[1] else {
                    return
                }
                endPoint = Location(z: z, x: x)
            }
        case let .string(text):
            if text == "start" {
                animateSphere()
            }
        default: break
        }
    }
}
