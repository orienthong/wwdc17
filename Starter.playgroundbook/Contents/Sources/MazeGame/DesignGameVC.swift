//
//  DesignGameVC.swift
//  MazeGame
//
//  Created by Hao Dong on 31/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit
import PlaygroundSupport

public class DesignGameVC: MasterGameVC, PlaygroundLiveViewSafeAreaContainer {
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureGameScene()
        
        // first we present welcome Scene.
        sceneView.scene = welcomeScene
        configurewelComeScene()
        
        matrix = [[0,0,0,1,0,0,1,0,0,0,0,1,0,1,0],
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

        sceneView.scene = welcomeScene
        
        positionBoxs()
        gameScene.rootNode.addChildNode(audioNode)
        gameScene.rootNode.addChildNode(popNode)
        gameScene.rootNode.addChildNode(winningNode)
        
        cameraYPosition = SCNVector3Make(0, 40, 0)
        configureGameSceneCamera()
        
        
        entrance = Location(z: 14, x: 0)
        terminalPoint = Location(z: 0, x: 12)
        currentPoint = entrance
        _currentPoint = currentPoint
        
        duraction = 20
        
        gameMenu.isHidden = true
        button.isHidden = true
    }
    func configureGameScene() {
        gameScene = SCNScene(named: "art.scnassets/MazeGame_3.scn")
        gameScene.lightingEnvironment.contents = UIImage(named: "img_skybox.jpg")
        gameScene.background.contents = UIImage(named: "img_skybox.jpg")
    }
    override func setUpView() {
        super.setUpView()
        gameMenu = GameMenuView()
        gameMenu.backgroundColor = UIColor.yellow.withAlphaComponent(0)
        sceneView.addSubview(gameMenu)
        gameMenu.translatesAutoresizingMaskIntoConstraints = false
        gameMenu.leadingAnchor.constraint(equalTo: liveViewSafeAreaGuide.leadingAnchor).isActive = true
        gameMenu.trailingAnchor.constraint(equalTo: liveViewSafeAreaGuide.trailingAnchor).isActive = true
        gameMenu.topAnchor.constraint(equalTo: liveViewSafeAreaGuide.topAnchor).isActive = true
        gameMenu.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    override func configureGameSceneCamera() {
        super.configureGameSceneCamera()
        cameraYHandle.position = cameraYPosition
    }
    override func GameBegin() {
        if cameraYHandle.position.y > 0.5 {
            _queue.dequeueAll()
            return
        }
        super.GameBegin()
    }
}

//playgroundSupport
extension DesignGameVC: PlaygroundLiveViewMessageHandler {
    public func receive(_ message: PlaygroundValue) {
        switch message {
        case let .integer(text):
            if text <= 3 {
                let integer = Int(text)
                _queue.enqueue(element: Direction(rawValue: integer)!)
            } else if text == 4 {
                _queue.dequeueAll()
            } else {
                GameBegin()
            }
            
        default:
            break
        }
        
    }
}


