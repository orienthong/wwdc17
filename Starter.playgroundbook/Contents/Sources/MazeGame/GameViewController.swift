//
//  GameViewController.swift
//  MazeGame
//
//  Created by Hao Dong on 27/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import SpriteKit
import PlaygroundSupport
public class GameViewController: MasterGameVC, PlaygroundLiveViewSafeAreaContainer {
        /// Use to convert PlaygroundValue array to a queue

    public override func viewDidLoad() {
        super.viewDidLoad()
        gameScene = SCNScene(named: "art.scnassets/MazeGame.scn")
        gameScene.fogColor = UIColor.white
        gameScene.lightingEnvironment.contents = UIImage(named: "img_skybox.jpg")

        gameScene.background.contents = UIImage(named: "img_skybox.jpg")

        // first we present welcome Scene.
        sceneView.scene = welcomeScene
        //b sceneView.showStatistics = true
        configurewelComeScene()

        matrix = [[1,1,1,1,1],
                  [1,0,0,0,1],
                  [1,0,1,0,1],
                  [1,0,1,0,0],
                  [1,0,1,1,1]]


        positionBoxs()
        gameScene.rootNode.addChildNode(audioNode)
        gameScene.rootNode.addChildNode(popNode)
        gameScene.rootNode.addChildNode(winningNode)

        cameraYPosition = SCNVector3Make(0, 15, 0)
        configureGameSceneCamera()

        entrance = Location(z: 4, x: 1)
        terminalPoint = Location(z: 3, x: 4)
        currentPoint = entrance
        _currentPoint = currentPoint

        duraction = 5

        gameMenu.isHidden = true
        button.isHidden = true

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
    override func showSuccessMessage() {
        super.showSuccessMessage()
        let Dict: PlaygroundValue = .dictionary(["success": PlaygroundValue.boolean(true)])
        send(Dict)
    }
    override func configureGameSceneCamera() {
        super.configureGameSceneCamera()
        cameraYHandle.position = cameraYPosition
    }


    override func presentGameScene() {
        super.presentGameScene()

    }

    override func presentWelcomeScene() {
        super.presentWelcomeScene()
    }

}
extension GameViewController: PlaygroundLiveViewMessageHandler {

    public func receive(_ message: PlaygroundValue) {
        switch message {
        case let .integer(text):
            if text <= 3 {
                let integer = Int(text)
                _queue.enqueue(element: Direction.init(rawValue: integer)!)
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
