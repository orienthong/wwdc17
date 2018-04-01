//
//  PhotoFrameVC.swift
//  AboutMe-3
//
//  Created by Hao Dong on 20/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit
import SceneKit
import QuartzCore
import AVFoundation
import PlaygroundSupport

public class PhotoFrameVC: UIViewController {
    
    
    //property goes here
    var scene: SCNScene!
    var sceneView: SCNView!
    
    let loadingQueue = OperationQueue()
    var presentNode = SCNNode()
    
    let colors = [#colorLiteral(red: 0.0352941192686558, green: 0.117647059261799, blue: 0.164705887436867, alpha: 1.0),#colorLiteral(red: 0.0470588244497776, green: 0.0, blue: 0.129411771893501, alpha: 1.0),#colorLiteral(red: 0.117647059261799, green: 0.0, blue: 0.0666666701436043, alpha: 1.0),#colorLiteral(red: 0.207843139767647, green: 0.0549019612371922, blue: 0.0117647061124444, alpha: 1.0),#colorLiteral(red: 0.200000002980232, green: 0.129411771893501, blue: 0.0196078438311815, alpha: 1.0),#colorLiteral(red: 0.0901960805058479, green: 0.133333340287209, blue: 0.0392156876623631, alpha: 1.0),
                  #colorLiteral(red: 0.0588235296308994, green: 0.180392161011696, blue: 0.24705882370472, alpha: 1.0),#colorLiteral(red: 0.062745101749897, green: 0.0, blue: 0.192156866192818, alpha: 1.0),#colorLiteral(red: 0.192156866192818, green: 0.00784313771873713, blue: 0.0901960805058479, alpha: 1.0),#colorLiteral(red: 0.317647069692612, green: 0.0745098069310188, blue: 0.0274509806185961, alpha: 1.0),#colorLiteral(red: 0.309803932905197, green: 0.20392157137394, blue: 0.0392156876623631, alpha: 1.0),#colorLiteral(red: 0.129411771893501, green: 0.215686276555061, blue: 0.0666666701436043, alpha: 1.0),
                  #colorLiteral(red: 0.10196078568697, green: 0.278431385755539, blue: 0.400000005960464, alpha: 1.0),#colorLiteral(red: 0.0901960805058479, green: 0.0, blue: 0.301960796117783, alpha: 1.0),#colorLiteral(red: 0.309803932905197, green: 0.0156862754374743, blue: 0.129411771893501, alpha: 1.0),#colorLiteral(red: 0.521568655967712, green: 0.109803922474384, blue: 0.0509803928434849, alpha: 1.0),#colorLiteral(red: 0.505882382392883, green: 0.337254911661148, blue: 0.0666666701436043, alpha: 1.0),#colorLiteral(red: 0.196078434586525, green: 0.341176480054855, blue: 0.10196078568697, alpha: 1.0),
                  #colorLiteral(red: 0.141176477074623, green: 0.396078437566757, blue: 0.564705908298492, alpha: 1.0),#colorLiteral(red: 0.121568627655506, green: 0.0117647061124444, blue: 0.423529416322708, alpha: 1.0),#colorLiteral(red: 0.439215689897537, green: 0.0117647061124444, blue: 0.192156866192818, alpha: 1.0),#colorLiteral(red: 0.745098054409027, green: 0.156862750649452, blue: 0.0745098069310188, alpha: 1.0),#colorLiteral(red: 0.725490212440491, green: 0.47843137383461, blue: 0.0980392172932625, alpha: 1.0),#colorLiteral(red: 0.274509817361832, green: 0.486274510622025, blue: 0.141176477074623, alpha: 1.0),
                  #colorLiteral(red: 0.176470592617989, green: 0.498039215803146, blue: 0.756862759590149, alpha: 1.0),#colorLiteral(red: 0.176470592617989, green: 0.0117647061124444, blue: 0.560784339904785, alpha: 1.0),#colorLiteral(red: 0.572549045085907, green: 0.0, blue: 0.23137255012989, alpha: 1.0),#colorLiteral(red: 0.925490200519562, green: 0.235294118523598, blue: 0.10196078568697, alpha: 1.0),#colorLiteral(red: 0.952941179275513, green: 0.686274528503418, blue: 0.133333340287209, alpha: 1.0),#colorLiteral(red: 0.341176480054855, green: 0.623529434204102, blue: 0.168627455830574, alpha: 1.0),
                  #colorLiteral(red: 0.239215686917305, green: 0.674509823322296, blue: 0.968627452850342, alpha: 1.0),#colorLiteral(red: 0.219607844948769, green: 0.00784313771873713, blue: 0.854901969432831, alpha: 1.0),#colorLiteral(red: 0.807843148708344, green: 0.0274509806185961, blue: 0.333333343267441, alpha: 1.0),#colorLiteral(red: 0.937254905700684, green: 0.34901961684227, blue: 0.192156866192818, alpha: 1.0),#colorLiteral(red: 0.960784316062927, green: 0.705882370471954, blue: 0.200000002980232, alpha: 1.0),#colorLiteral(red: 0.466666668653488, green: 0.764705896377563, blue: 0.266666680574417, alpha: 1.0),
                  #colorLiteral(red: 0.258823543787003, green: 0.756862759590149, blue: 0.968627452850342, alpha: 1.0),#colorLiteral(red: 0.364705890417099, green: 0.0666666701436043, blue: 0.968627452850342, alpha: 1.0),#colorLiteral(red: 0.854901969432831, green: 0.250980406999588, blue: 0.47843137383461, alpha: 1.0),#colorLiteral(red: 0.941176474094391, green: 0.498039215803146, blue: 0.352941185235977, alpha: 1.0),#colorLiteral(red: 0.968627452850342, green: 0.780392169952393, blue: 0.345098048448563, alpha: 1.0),#colorLiteral(red: 0.584313750267029, green: 0.823529422283173, blue: 0.419607847929001, alpha: 1.0),
                  #colorLiteral(red: 0.474509805440903, green: 0.839215695858002, blue: 0.976470589637756, alpha: 1.0),#colorLiteral(red: 0.556862771511078, green: 0.352941185235977, blue: 0.968627452850342, alpha: 1.0),#colorLiteral(red: 0.909803926944733, green: 0.47843137383461, blue: 0.643137276172638, alpha: 1.0),#colorLiteral(red: 0.95686274766922, green: 0.658823549747467, blue: 0.545098066329956, alpha: 1.0),#colorLiteral(red: 0.976470589637756, green: 0.850980401039124, blue: 0.549019634723663, alpha: 1.0),#colorLiteral(red: 0.721568644046783, green: 0.886274516582489, blue: 0.592156887054443, alpha: 1.0),
                  #colorLiteral(red: 0.803921580314636, green: 0.803921580314636, blue: 0.803921580314636, alpha: 1.0),#colorLiteral(red: 0.600000023841858, green: 0.600000023841858, blue: 0.600000023841858, alpha: 1.0),#colorLiteral(red: 0.501960813999176, green: 0.501960813999176, blue: 0.501960813999176, alpha: 1.0),#colorLiteral(red: 0.254901975393295, green: 0.274509817361832, blue: 0.301960796117783, alpha: 1.0),#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),#colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)]
    
    var frame = PhotoFrame(frameNode: ["Circle01","Circle02","Rectangle08"])
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        loadingQueue.addOperation { [weak self] in
            self?.configureScene()
            DispatchQueue.main.async {
                self?.sceneView.scene = self?.scene
            }
        }
        sceneView.allowsCameraControl = false
        
        //add TapGestureRecognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapped(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (!UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            
        }
    }
    
    private func showImagePicker() {
        let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        if (authStatus == .denied) {
            let alertController = UIAlertController(title: "Unable to access the camera", message: "To enable access, go to Settings > Privacy > Camera and turn on Camera access for this app", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else if authStatus == .notDetermined {
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { granted in
                if granted {
                    self.showImagePicker(for: .photoLibrary)
                }
            })
        } else {
            self.showImagePicker(for: .photoLibrary)
        }
    }
    
    private func showImagePicker(for type: UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.modalPresentationStyle = .pageSheet
        //        imagePickerController.popoverPresentationController
        imagePickerController.sourceType = type
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneView.bounds = view.bounds
        sceneView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
    }
    
    func handleTapped(_ sender: UIGestureRecognizer) {
        let position = sender.location(in: sceneView)
        let hitResults = sceneView.hitTest(position, options: [:])
        if hitResults.count > 0 {
            let result: AnyObject = hitResults[0]
            let material = result.node!.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.red
            
            SCNTransaction.commit()
            
            for i in 0 ... frame.frameNode.count-1 {
                if result.node!.name == frame.frameNode[i] {
                    presentNode = result.node!
                    showImagePicker()
                }
            }
        }
    }
    
    private func configureScene() {
        scene = SCNScene(named: "art.scnassets/photoScene.scn")!
    }
    
    func setUpViews() {
        sceneView = SCNView()
        view.addSubview(sceneView)
        
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sceneView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
}

extension PhotoFrameVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let key = UIImagePickerControllerOriginalImage
        
        if let image = info[key] as? UIImage {
            presentNode.geometry?.materials[1].diffuse.contents = image
        } else {
            print("error")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PhotoFrameVC {
    func changefirstFrameColor(at index: Int) {
        let firstFrame = scene.rootNode.childNode(withName: "\(frame.frameNode[0])", recursively: true)?.geometry?.firstMaterial?.diffuse
        firstFrame?.contents = colors[index]
    }
    func changeSecondFrameColor(at index: Int) {
        let secondFrame = scene.rootNode.childNode(withName: "\(frame.frameNode[1])", recursively: true)?.geometry?.firstMaterial?.diffuse
        secondFrame?.contents = colors[index]
    }
    func changeThirdFrameColor(at index: Int) {
        let thirdFrame = scene.rootNode.childNode(withName: "\(frame.frameNode[2])", recursively: true)?.geometry?.firstMaterial?.diffuse
        thirdFrame?.contents = colors[index]
    }
    func changeFloorColor(at index: Int) {
        let floor = scene.rootNode.childNode(withName: "floor", recursively: true)?.geometry?.firstMaterial?.diffuse
        floor?.contents = colors[index]
    }
    func changePlaneColor(at index: Int) {
        let plane = scene.rootNode.childNode(withName: "background", recursively: true)?.geometry?.firstMaterial?.diffuse
        plane?.contents = colors[index]
    }
    func changeSpotLightColor(at index: Int) {
        let spotLight = scene.rootNode.childNode(withName: "spot", recursively: true)?.light
        spotLight?.color = colors[index]
    }
    func showText(_ hidden: Bool) {
        
    }
}


extension PhotoFrameVC: PlaygroundLiveViewMessageHandler  {
    public func receive(_ message: PlaygroundValue) {
        if case let .dictionary(dic) = message {
            if case let .integer(colorIndex)? = dic["firstFrame"] {
                changefirstFrameColor(at: colorIndex)
            } else if case let .integer(colorIndex)? = dic["secondFrame"] {
                changeSecondFrameColor(at: colorIndex)
            } else if case let .integer(colorIndex)? = dic["thridFrame"] { //third Frame color
                changeThirdFrameColor(at: colorIndex)
            } else if case let .integer(colorIndex)? = dic["floor"] { // floor color
                changeFloorColor(at: colorIndex)
            } else if case let .integer(colorIndex)? = dic["background"] { //plane color
                changePlaneColor(at: colorIndex)
            } else if case let .integer(colorIndex)? = dic["spotLight"] {
                changeSpotLightColor(at: colorIndex)
            }
        } else if case let .boolean(hideText) = message { // show text or not

                showText(Bool(hideText))
        }
    }
}


