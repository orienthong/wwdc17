//
//  MasterGameVC.swift
//  MazeGame
//
//  Created by Hao Dong on 31/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit
import PlaygroundSupport

enum Direction: Int {
    case forward = 0
    case left
    case backward
    case right
}

struct Location {
    var x: Int
    var z: Int
    init(z: Int, x: Int) {
        self.x = x
        self.z = z
    }
}
extension Location: Equatable {
}
func ==(lhs: Location, rhs: Location) -> Bool {
    if lhs.x == rhs.x && lhs.z == rhs.z { return true }
    return false
}
public class MasterGameVC: UIViewController {
    let helper = GameHelper()
    var matrix = [[1,1,1,1,1,0,1],
                  [1,0,0,0,1,1,1],
                  [1,0,1,0,1,1,1],
                  [1,0,1,0,0,0,1],
                  [1,0,1,1,1,1,1],
                  [1,1,1,1,1,1,1],
                  [1,1,1,1,1,1,1]]
    
    var gameScene: SCNScene!
    var sceneView: SCNView!
    var gameMenu: GameMenuView!
    var cameraNode: SCNNode!
    var resetButton = UIButton()
    
    var position: SCNVector3? = nil
    
    private var confettiParticleSystem: SCNParticleSystem!
    
    private let forWardDuraction = 1.0
    private let goBackDuraction = 0.3
    
    var queue: Queue<Direction>? = nil
    var _queue = Queue<Direction>()
    var stack: Stack<Direction>? = nil
    
    var entrance = Location(z: 3, x: 5)
    var terminalPoint = Location(z: 4, x: 1)
    var currentPoint = Location(z: 3, x: 5)
    var _currentPoint = Location(z: 3, x: 5)
    
    var welcomeScene: SCNScene!
    
    //test
    var button: UIButton!
    
    internal var panningTouch: UITouch?
    let cameraXHandle = SCNNode()
    let cameraYHandle = SCNNode()
    var isLocked = false
    
    var cameraYPosition = SCNVector3Make(0, 15, 0)
    
    
    /// the cameraDirection, +z: .froward, +x: .right
    var cameraDirection: Direction = .forward
    
    
    let WelcomeMatrix = [[1,1,1,0,0],
                         [1,0,0,0,1],
                         [0,0,1,0,1],
                         [1,0,1,0,0],
                         [1,0,1,1,1]]
    
    
    var audioNode: SCNNode!
    var audioSourse: SCNAudioSource!
    
    var popNode: SCNNode!
    var popSourse: SCNAudioSource!
    
    var winningNode: SCNNode!
    var winningSourse: SCNAudioSource!
    
    var label: UILabel!
    var duraction: CFTimeInterval!
    private var centerX: CGFloat!
    private var maxX: CGFloat!
    private var minX: CGFloat!
    private var num = 0
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        confettiParticleSystem = SCNParticleSystem(named: "art.scnassets/confetti.scnp", inDirectory: nil)
        
        
        // test
        queue = Queue<Direction>()
        stack = Stack<Direction>()
        button = UIButton(type: .system)
        button.setTitle("Tapped", for: .normal)
        sceneView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: sceneView.topAnchor, constant: 20).isActive = true
        button.trailingAnchor.constraint(equalTo: sceneView.trailingAnchor, constant: -10).isActive = true
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        //-end-test
        
        resetButton = gameMenu.resetButton
        resetButton.addTarget(self, action: #selector(resetButtonTapped(_:)), for: .touchUpInside)
        
        welcomeScene = SCNScene(named: "art.scnassets/welcome.scn")
        
        audioSourse = SCNAudioSource(named: "background.mp3")!
        audioSourse.loops = true
        audioSourse.load()
        let player = SCNAudioPlayer(source: audioSourse)
        audioNode = SCNNode()
        audioNode.addAudioPlayer(player)

        
        popSourse = SCNAudioSource(named: "pop.mp3")!
        popSourse.loops = false
        popSourse.load()
        popNode = SCNNode()
        popNode.addAudioPlayer(SCNAudioPlayer(source: popSourse))
        
        winningSourse = SCNAudioSource(named: "winning.mp3")!
        winningSourse.loops = false
        winningSourse.load()
        winningNode = SCNNode()
        winningNode.addAudioPlayer(SCNAudioPlayer(source: winningSourse))
        
        label = UILabel()
        duraction = CFTimeInterval(3.0)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        label.font = UIFont.systemFont(ofSize: 72)
        label.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
    }
    func beginTiming() {
        num = Int(duraction)
        centerX = view.center.x
        maxX = view.frame.maxX
        minX = view.frame.minX
        labeldoNext()
    }
    private func animate() {
        self.label.text = "\(num)"
        self.label.alpha = 0
        let animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut, animations: {
            UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.15, animations: {
                    self.label.center.x = self.centerX - 50
                    self.label.alpha = 0.3
                })
                UIView.addKeyframe(withRelativeStartTime: 0.15, relativeDuration: 0.35, animations: {
                    self.label.center.x = self.centerX - 25
                    self.label.alpha = 0.8
                })
                UIView.addKeyframe(withRelativeStartTime: 0.35, relativeDuration: 0.45, animations: {
                    self.label.center.x = self.centerX - 10
                    self.label.alpha = 0.9
                })
                UIView.addKeyframe(withRelativeStartTime: 0.45, relativeDuration: 0.5, animations: {
                    self.label.center.x = self.centerX
                    self.label.alpha = 1
                })
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.55, animations: {
                    self.label.center.x = self.centerX + 10
                    self.label.alpha = 0.9
                })
                UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.65, animations: {
                    self.label.center.x = self.centerX + 25
                    self.label.alpha = 0.8
                })
                UIView.addKeyframe(withRelativeStartTime: 0.65, relativeDuration: 0.75, animations: {
                    self.label.center.x = self.centerX + 50
                    self.label.alpha = 0.3
                })
                UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 1, animations: {
                    self.label.center.x = self.maxX + 10
                    self.label.alpha = 0
                })
                
            }, completion: { (finished) in
                if finished {
                    print(finished)
                    self.labeldoNext()
                }
            })
        })
        animator.startAnimation()
    }
    func labeldoNext() {
        guard num > 0 else {
            return
        }
        animate()
        num -= 1
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gameMenu.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        
    }
    //present welcome scene, purse the game
    func configurewelComeScene() {
        gameScene.removeAllParticleSystems()
        resetButton.isEnabled = false
        cameraYHandle.position = cameraYPosition
        cameraYHandle.eulerAngles = SCNVector3Make(Float(-90).degreesToRadians, 0, 0)
        sceneView.isUserInteractionEnabled = false
        helper.state = .tapToBegin
        let sphereNode = welcomeScene.rootNode.childNode(withName: "sphere", recursively: true)!
        sphereNode.removeAllActions()
        sphereNode.position = SCNVector3Make(-1, 0.5, 2)
        //let cameraNode = scene.rootNode.childNode(withName: "camera", recursively: true)!
        if let directions = helper.Check(with: WelcomeMatrix, startPoint: Location(z: 4, x: 1), endPoint: Location(z: 3, x: 4)) {
            print(directions)
            let directionQueue = helper.getAnimationQueue(with: directions)
            let action = helper.getSequenceActions(from: directionQueue)
            
            //we should  switch the directions
            let switchDirectionQueue = helper.reverseAll(directions: directionQueue)
            var actions = helper.getActions(form: switchDirectionQueue)
            actions.reverse()
            
            //reversed the directionQueue so it will go back
            let backAction = SCNAction.sequence(actions)
            
            let repeatAction = SCNAction.sequence([action, backAction])
            sphereNode.runAction(SCNAction.repeatForever(repeatAction))
            print("aabbcc")
        }
    }
    //present welcome scene, purse the game
    func presentWelcomeScene() {
        sceneView.present(welcomeScene, with: .crossFade(withDuration: 0.5), incomingPointOfView: nil, completionHandler: nil)
        configurewelComeScene()
    }
    
    //present game scene. when presented , begin timming
    func presentGameScene() {
        let particlesyc = SCNParticleSystem(named: "collect.scnp", inDirectory: nil)!
        let particleNode = SCNNode()
        particleNode.position = SCNVector3Make(Float(terminalPoint.x-matrix.count/2), 0, Float(terminalPoint.z-matrix.count/2))
        var particleSystemPosition = particleNode.worldTransform
        particleSystemPosition.m42 += 0.1
        gameScene.addParticleSystem(particlesyc, transform: particleSystemPosition)
        audioNode.removeAllAudioPlayers()
        audioNode.runAction(SCNAction.playAudio(audioSourse, waitForCompletion: false))
        resetButton.isEnabled = false
        delay(delay: 2, closure: {
            
            self.beginTiming()
        })
        sceneView.present(gameScene, with: .crossFade(withDuration: 0.1), incomingPointOfView: nil) {
            self.sceneView.pointOfView?.eulerAngles = SCNVector3Zero
            self.sceneView.isUserInteractionEnabled = true
            self.helper.state = .began
            //self.gameMenu.beginTiming()
            //self.positionBoxs()
        }
        delay(delay: Double(duraction+1), closure: {
            SCNTransaction.animateWithDuration(0.8, timingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut), completionBlock: {
                self.isLocked = false
                self.resetButton.isEnabled = true
                
                
            }, animations: {
                self.cameraYHandle.position = SCNVector3Make(Float(self.entrance.x-self.matrix.count/2), 0.5, Float(self.entrance.z-self.matrix.count/2))
                self.cameraYHandle.rotation = SCNVector4Zero
                
            })
        })
    }
    
    
    // restart game
    func resetButtonTapped(_ sender: UIButton!) {
        queue = nil
        stack = Stack<Direction>()
        cameraDirection = .forward
        currentPoint = _currentPoint
        cameraYHandle.removeAllActions()
        delay(delay: 0.1, closure: {
            SCNTransaction.animateWithDuration(0.5, timingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut), completionBlock: {
                self.isLocked = true
            }, animations: {
                self.cameraYHandle.position = self.cameraYPosition
                self.cameraYHandle.eulerAngles = SCNVector3Make(Float(-90).degreesToRadians, 0, 0)
                self.cameraXHandle.position = SCNVector3Zero
                self.cameraXHandle.eulerAngles = SCNVector3Zero
                self.cameraNode.position = SCNVector3Zero
                self.cameraNode.eulerAngles = SCNVector3Zero
            })
        })
        presentWelcomeScene()
    }
    //test
    func buttonTapped(_ sender: UIButton!) {
        queue = nil
        reverse()
    }
    //-end-test
    
    
    /// Use to convert PlaygroundValue array to a queue
    
    
    
    func setUpView() {
        sceneView = SCNView()
        view.addSubview(sceneView)
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sceneView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        queue?.enqueue(element: Direction(rawValue: 0)!)
        
        sceneView.showsStatistics = true
        
        //sceneView.overlaySKScene
        //let skScene = SKScene()
        
        
    }
    // MARK: -Manage games
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
                    boxNode.geometry = box
                    boxNode.name = "boxs"
                    position = SCNVector3Make(xPosition, 0.5, zPosition)
                    gameScene.rootNode.addChildNode(boxNode)
                    boxNode.position = position!
                } else {
                    position = nil
                    //print(position)
                }
            }
            
        }
    }
    //
    func configureGameSceneCamera() {
        isLocked = true
        cameraNode = gameScene.rootNode.childNode(withName: "camera", recursively: true)!
        cameraNode.camera?.zFar = 100
        cameraNode.camera?.zNear = 0.3
        cameraNode.camera?.motionBlurIntensity = 0.5
        
        gameScene.rootNode.addChildNode(cameraYHandle)
        cameraYHandle.position = cameraYPosition
        cameraYHandle.eulerAngles = SCNVector3Make(Float(-90).degreesToRadians, 0, 0)
        cameraYHandle.addChildNode(cameraXHandle)
        cameraXHandle.position = SCNVector3Zero
        cameraXHandle.eulerAngles = SCNVector3Zero
        
        cameraXHandle.addChildNode(cameraNode)
        cameraNode.position = SCNVector3Zero
        cameraNode.eulerAngles = SCNVector3Zero
        sceneView.pointOfView = cameraNode
    }
    func showFailMessage() { }
    func shackCamera() {
        let shackDuraction = 0.05
        cameraNode.camera?.motionBlurIntensity = 0.5
        let action = SCNAction.sequence([SCNAction.rotateBy(x: 0, y: CGFloat(5).degreesToRadians, z: 0, duration: shackDuraction),SCNAction.rotateBy(x: 0, y: CGFloat(-10).degreesToRadians, z: 0, duration: shackDuraction),SCNAction.rotateBy(x: 0, y: CGFloat(5).degreesToRadians, z: 0, duration: shackDuraction)])
        let actions = SCNAction.repeat(action, count: 4)
        actions.timingMode = .easeOut
        cameraYHandle.runAction(actions, forKey: nil)
        showFailMessage()
    }
    func showSuccessMessage() { }
    // MARK: -forWard animation
    func animateForWard() {
        
        func presentParticleSystem() {
            if currentPoint == terminalPoint { // yep we win
                print("abcd")
                let scale = SCNMatrix4MakeScale(1, 1, 1)
                gameScene.addParticleSystem(confettiParticleSystem, transform: scale)
                winningNode.runAction(SCNAction.playAudio(winningSourse, waitForCompletion: false))
                showSuccessMessage()
            }
        }
        switch cameraDirection {
        case .forward:
            guard currentPoint.z-1 >= 0 else {
                popNode.runAction(SCNAction.playAudio(popSourse, waitForCompletion: false))
                self.shackCamera()
                _ = self.stack?.pop()//pop the last because it is illegal
                return
            }
            if matrix[currentPoint.z-1][currentPoint.x] == 0 {
                cameraYHandle.runAction(SCNAction.move(by: SCNVector3Make(0, 0, -1), duration: forWardDuraction), forKey: nil, completionHandler: {
                    self.currentPoint.z -= 1
                    print(self.currentPoint)
                    presentParticleSystem()
                    self.doNext()
                })
            }else { //not allow to move
                popNode.runAction(SCNAction.playAudio(popSourse, waitForCompletion: false))
                self.shackCamera()
                _ = self.stack?.pop()//dequeue the last because it is illegal
                print("1")
            }
        case .left:
            guard currentPoint.x-1 >= 0 else {
                
                popNode.runAction(SCNAction.playAudio(popSourse, waitForCompletion: false))
                self.shackCamera()
                _ = self.stack?.pop()//dequeue the last because it is illegal
                return
            }
            if matrix[currentPoint.z][currentPoint.x-1] == 0 {
                cameraYHandle.runAction(SCNAction.move(by: SCNVector3Make(-1, 0, 0), duration: forWardDuraction), forKey: nil, completionHandler: {
                    self.currentPoint.x -= 1
                    print(self.currentPoint)
                    presentParticleSystem()
                    self.doNext()
                })
            }else {
                
                popNode.runAction(SCNAction.playAudio(popSourse, waitForCompletion: false))
                self.shackCamera()
                _ = self.stack?.pop()//dequeue the last because it is illegal
                print("2")
            }
        case .backward:
            guard currentPoint.z+1 < matrix.count else {
                
                popNode.runAction(SCNAction.playAudio(popSourse, waitForCompletion: false))
                self.shackCamera()
                _ = self.stack?.pop()//dequeue the last because it is illegal
                return
            }
            if matrix[currentPoint.z+1][currentPoint.x] == 0 {
                cameraYHandle.runAction(SCNAction.move(by: SCNVector3Make(0, 0, 1), duration: forWardDuraction), forKey: nil, completionHandler: {
                    self.currentPoint.z += 1
                    presentParticleSystem()
                    self.doNext()
                })
            } else {
                popNode.runAction(SCNAction.playAudio(popSourse, waitForCompletion: false))
                self.shackCamera()
                _ = self.stack?.pop()//dequeue the last because it is illegal
                print("3")
            }
        case .right:
            guard currentPoint.x+1 < matrix.count else {
                
                popNode.runAction(SCNAction.playAudio(popSourse, waitForCompletion: false))
                self.shackCamera()
                _ = self.stack?.pop()//dequeue the last because it is illegal
                return
            }
            if matrix[currentPoint.z][currentPoint.x+1] == 0 {
                
                cameraYHandle.runAction(SCNAction.move(by: SCNVector3Make(1, 0, 0), duration: forWardDuraction), forKey: nil, completionHandler: {
                    self.currentPoint.x += 1
                    presentParticleSystem()
                    self.doNext()
                })
            }else {
                
                popNode.runAction(SCNAction.playAudio(popSourse, waitForCompletion: false))
                self.shackCamera()
                _ = self.stack?.pop()//dequeue the last because it is illegal
                print("4")
            }
        }
    }
    
    func animateBackWard() {
        switch cameraDirection {
        case .forward:
            cameraYHandle.runAction(SCNAction.move(by: SCNVector3Make(0, 0, 1), duration: forWardDuraction), forKey: nil, completionHandler: {
                self.doNext()
            })
        case .backward:
            cameraYHandle.runAction(SCNAction.move(by: SCNVector3Make(0, 0, -1), duration: forWardDuraction), forKey: nil, completionHandler: {
                self.doNext()
            })
        case .left:
            cameraYHandle.runAction(SCNAction.move(by: SCNVector3Make(1, 0, 0), duration: forWardDuraction), forKey: nil, completionHandler: {
                self.doNext()
            })
        case .right:
            cameraYHandle.runAction(SCNAction.move(by: SCNVector3Make(-1, 0, 0), duration: forWardDuraction), forKey: nil, completionHandler: {
                self.doNext()
            })
        }
    }
    func animateToLeft() {
        switch cameraDirection {
        case .forward:
            cameraDirection = .left
        case .left:
            cameraDirection = .backward
        case .backward:
            cameraDirection = .right
        case .right:
            cameraDirection = .forward
        }
        isLocked = true
        
        cameraYHandle.runAction(.rotateBy(x: 0, y: CGFloat(90).degreesToRadians, z: 0, duration: forWardDuraction), forKey: nil, completionHandler: {
            self.isLocked = false
            self.doNext()
        })
    }
    func animateToRight() {
        switch cameraDirection {
        case .forward:
            cameraDirection = .right
        case .right:
            cameraDirection = .backward
        case .backward:
            cameraDirection = .left
        case .left:
            cameraDirection = .forward
        }
        isLocked = true
        cameraYHandle.runAction(.rotateBy(x: 0, y: CGFloat(-90).degreesToRadians, z: 0, duration: forWardDuraction), forKey: nil, completionHandler: {
            self.isLocked = false
            self.doNext()
        })
    }
    func run() {
        //the effect not good
        cameraNode.camera?.motionBlurIntensity = 0.0
        doNext()
    }
    func doNext() {
        guard let direction = queue?.dequeue() else {
            return
        }
        push(direction)
        delay(delay: 0.0, closure: {
            switch direction {
            case .forward:
                self.animateForWard()
            case .backward:
                self.animateBackWard()
            case .left:
                self.animateToLeft()
            case .right:
                self.animateToRight()
            }
        })
    }
    
    // MARK: -goBack animation
    /// Optional
    func backForWard() {
        switch cameraDirection {
        case .forward:
            cameraYHandle.runAction(SCNAction.move(by: SCNVector3Make(0, 0, -1), duration: goBackDuraction), forKey: nil, completionHandler: {
                self.goBack()
            })
        case .left:
            cameraYHandle.runAction(SCNAction.move(by: SCNVector3Make(-1, 0, 0), duration: goBackDuraction), forKey: nil, completionHandler: {
                self.goBack()
            })
        case .backward:
            cameraYHandle.runAction(SCNAction.move(by: SCNVector3Make(0, 0, 1), duration: goBackDuraction), forKey: nil, completionHandler: {
                self.goBack()
            })
        case .right:
            cameraYHandle.runAction(SCNAction.move(by: SCNVector3Make(1, 0, 0), duration: goBackDuraction), forKey: nil, completionHandler: {
                self.goBack()
            })
        }
    }
    func backBackWard() {
        switch cameraDirection {
        case .forward:
            cameraYHandle.runAction(SCNAction.move(by: SCNVector3Make(0, 0, 1), duration: goBackDuraction), forKey: nil, completionHandler: {
                self.goBack()
            })
        case .backward:
            cameraYHandle.runAction(SCNAction.move(by: SCNVector3Make(0, 0, -1), duration: goBackDuraction), forKey: nil, completionHandler: {
                self.goBack()
            })
        case .left:
            cameraYHandle.runAction(SCNAction.move(by: SCNVector3Make(1, 0, 0), duration: goBackDuraction), forKey: nil, completionHandler: {
                self.goBack()
            })
        case .right:
            cameraYHandle.runAction(SCNAction.move(by: SCNVector3Make(-1, 0, 0), duration: goBackDuraction), forKey: nil, completionHandler: {
                self.goBack()
            })
        }
    }
    func backToLeft() {
        switch cameraDirection {
        case .forward:
            cameraDirection = .left
        case .left:
            cameraDirection = .backward
        case .backward:
            cameraDirection = .right
        case .right:
            cameraDirection = .forward
        }
        isLocked = true
        
        cameraYHandle.runAction(.rotateBy(x: 0, y: CGFloat(90).degreesToRadians, z: 0, duration: goBackDuraction), forKey: nil, completionHandler: {
            self.isLocked = false
            self.goBack()
        })
    }
    func backToRight() {
        switch cameraDirection {
        case .forward:
            cameraDirection = .right
        case .right:
            cameraDirection = .backward
        case .backward:
            cameraDirection = .left
        case .left:
            cameraDirection = .forward
        }
        isLocked = true
        cameraYHandle.runAction(.rotateBy(x: 0, y: CGFloat(-90).degreesToRadians, z: 0, duration: goBackDuraction), forKey: nil, completionHandler: {
            self.isLocked = false
            self.goBack()
        })
    }
    func reverse() {
        
        cameraNode.camera?.motionBlurIntensity = 0.5
        goBack()
        
    }
    func goBack() {
        guard let direction = stack?.pop() else {
            convertArrayToQueue()
            return
        }
        
        delay(delay: 0.0, closure: {
            switch direction {
            case .forward:
                self.backForWard()
            case .backward:
                self.backBackWard()
            case .left:
                self.backToLeft()
            case .right:
                self.backToRight()
            }
        })
    }
    
    private func push(_ direction: Direction) {
        switch direction {
        case .forward:
            stack?.push(element: .backward)
        case .backward:
            stack?.push(element: .forward)
        case .left:
            stack?.push(element: .right)
        case .right:
            stack?.push(element: .left)
        }
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
        if helper.state == .tapToBegin {
            presentGameScene()
        }
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
    
    func convertArrayToQueue() {
        currentPoint = _currentPoint
        queue = Queue<Direction>()
        queue = _queue
        run()
    }
    func GameBegin() {
        if helper.state == .tapToBegin {
            presentGameScene()
        } else if cameraYHandle.position.y != Float(15) {
            queue = nil
            reverse()
        }
    }

}
