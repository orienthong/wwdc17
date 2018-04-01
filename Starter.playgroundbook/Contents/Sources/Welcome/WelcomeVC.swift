//
//  WelComeVC.swift
//  AboutMe
//
//  Created by Hao Dong on 12/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//
import PlaygroundSupport
import UIKit
import AVFoundation

public class WelComeVC: UIViewController {
    
    // Property
    var backgroundImageView = UIImageView()
    
    var topStackView = UIStackView()
    var imageView = UIImageView()
    var aboutMeLabel = UILabel()
    
    //bottom messageView
    var messageView = UIView()
    
    //sentences
    var sentencesSV = UIStackView()
    var sentences = [UIStackView]()
    
    //speech context
    let synthesizer = AVSpeechSynthesizer()
    
    /// SuperView layoutMargins
    var margins = UILayoutGuide()
    
    
    /// name that user can type
    var name = ""
    
    func setUpView() {
        setUpBackgroundImage()
        setUpTopView()
        layoutTopStackView(with: traitCollection.verticalSizeClass)
        setUpMessageView()
        setUpSentencesSV()
        setUpSentences()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        margins = view.layoutMarginsGuide
        setUpView()
        
        showFirstTwoSentences()
    }
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    public override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        layoutTopStackView(with: newCollection.verticalSizeClass)
        
    }
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (_) in
            self.topStackView.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            self.messageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.messageView.alpha = 0.0
        }) { (_) in
            UIView.animate(withDuration: 0.5, animations: {
                self.topStackView.transform = CGAffineTransform.identity
                self.messageView.transform = CGAffineTransform.identity
                self.messageView.alpha = 1.0
            })
        }
    }
}

// MARK: - setUp View
extension WelComeVC {
    
    /// setUp and layout backgroundImage
    func setUpBackgroundImage () {
        view.backgroundColor = UIColor(red: 80/256.0, green: 104/256.0, blue: 246/256.0, alpha: 1)
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.image = UIImage(named: "bg.png")
        NSLayoutConstraint(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.contentMode = .scaleAspectFill
    }
    func setUpTopView() {
        view.addSubview(topStackView)
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "aavatar.png")
        imageView.layer.masksToBounds = true
        
        topStackView.addArrangedSubview(imageView)
        aboutMeLabel.text = "Hello, my name is HaoDong Hong,  last month, I celebrated my 18th birtherday. I am currently a sophomore in SCAU, China. I started programming at the age of 17. "
        aboutMeLabel.textColor = UIColor.white
        aboutMeLabel.numberOfLines = 0
        aboutMeLabel.adjustsFontForContentSizeCategory = true
        aboutMeLabel.backgroundColor = UIColor.white.withAlphaComponent(0)
        topStackView.addArrangedSubview(aboutMeLabel)
    }
    func layoutTopStackView(with size: UIUserInterfaceSizeClass) {
        
        // remove previous constraints
        let constraints = topStackView.constraints
        topStackView.removeConstraints(constraints)
        
        topStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        topStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -10).isActive = true
        topStackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 10).isActive = true
        //topStackView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1).isActive = true
        
        func setUpCompact() {
            topStackView.distribution = .fillProportionally
            topStackView.axis = .horizontal
            topStackView.alignment = .fill
            topStackView.spacing = 10
            //setUpFontStyle here
            aboutMeLabel.font = UIFont(name: "Chalkboard SE", size: 19.0)
            topStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            //imageView.layer.cornerRadius = 50
            
        }
        func setUpRegular() {
            topStackView.axis = .vertical
            topStackView.distribution = .fillEqually
            topStackView.alignment = .center
            aboutMeLabel.font = UIFont(name: "Chalkboard SE", size: 19.0)
            topStackView.spacing = 5
            topStackView.heightAnchor.constraint(equalToConstant: 300).isActive = true
//            imageView.layer.cornerRadius = 70
        }
        
        switch size {
        case .compact:
            setUpCompact()
        case .unspecified:
            fallthrough
        case .regular:
            setUpRegular()
        }
    }
    func setUpMessageView() {
        view.addSubview(messageView)
        messageView.translatesAutoresizingMaskIntoConstraints = false
        messageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        messageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        messageView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10).isActive = true
        messageView.layer.masksToBounds = false
        messageView.layer.shadowColor = UIColor.black.cgColor
        messageView.layer.shadowOpacity = 1.0
        messageView.layer.shadowRadius = 30.0
        messageView.layer.shadowOffset = CGSize(width: 0, height: 30)
        //messageView.backgroundColor = UIColor.white
    }
    func setUpSentencesSV() {
        messageView.addSubview(sentencesSV)
        sentencesSV.axis = .vertical
        sentencesSV.translatesAutoresizingMaskIntoConstraints = false
        sentencesSV.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 8).isActive = true
        sentencesSV.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -8).isActive = true
        sentencesSV.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 10).isActive = true
        sentencesSV.bottomAnchor.constraint(equalTo: messageView.bottomAnchor, constant: -10).isActive = true
        sentencesSV.alignment = .fill
        sentencesSV.distribution = .fillEqually
        sentencesSV.spacing = 5
    }
    func setUpSentences() {
        
        for i in 0 ... 5 {
            let messageSV = UIStackView()
            messageSV.translatesAutoresizingMaskIntoConstraints = false
            messageSV.axis = .horizontal
            let label = UILabel()
            label.text = ""
            label.textColor = UIColor.white
            label.adjustsFontForContentSizeCategory = true
            let image = UIImageView()
            image.image = #imageLiteral(resourceName: "avatar.png")
            image.clipsToBounds = true
            image.layer.masksToBounds = true
            image.layer.cornerRadius = 20
            if i == 2 || i == 4 {
                messageSV.addArrangedSubview(image)
                messageSV.addArrangedSubview(label)
                label.textAlignment = .left
                image.image = UIImage(named: "Group 10.png")
            }else {
                messageSV.addArrangedSubview(label)
                messageSV.addArrangedSubview(image)
                label.textAlignment = .right
                image.image = UIImage(named: "aavatar.png")
            }
            messageSV.spacing = 5
            //add constraint to subImageView
            image.translatesAutoresizingMaskIntoConstraints = false
            image.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1).isActive = true
            sentencesSV.addArrangedSubview(messageSV)
            sentences.append(messageSV)
            label.font = UIFont(name: "American Typewriter", size: 17)
            label.numberOfLines = 0
            messageSV.alpha = 0.0
        }
    }
    
    
    /// show and animate sentence at index
    ///
    /// - Parameters:
    ///   - index: index
    ///   - message: the sentence text
    func display(at index: Int, with message: String) {
        
        if index == 2 || index == 4 {
            let label = sentences[index].subviews[1] as! UILabel
            label.text = message
        } else {
            let label = sentences[index].subviews[0] as! UILabel
            label.text = message
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.sentences[index].alpha = 1.0
        })
    }
    
    
    /// speech message
    ///
    /// - Parameter text: String
    func speech(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        synthesizer.speak(utterance)
    }
    
    func showFirstTwoSentences() {
        speech("Hello, Nice to meet you.")
        display(at: 0, with: "Hello, Nice to meet you.😁")
        delay(delay: 3, closure: {
            self.speech("may I know your name?")
            self.display(at: 1, with: "may I know your name?")
        })

    }
    
    func isNameVaild(name: String) -> Bool {
        return false
    }
    
    func showThirdSentence(with message: String) {
        if User.name != User.previousName {
            if sentences[2].alpha != 0 {
                for i in 2 ... sentences.count - 1 {
                    UIView.animate(withDuration: 0.7, animations: {
                        self.sentences[i].alpha = 0.0
                    })
                }
            }
        
        if message == "<#name#>" {
            
            display(at: 2, with: "I didn't have a name.")
            
            delay(delay: 3, closure: {
                self.speech("ah, so I can call you Mr. Empty?")
                self.showAssessment(with: " ### **Type your name** in the first rectangle.", success: false)
                self.showForthSenctece(with: "ah, so I can call you Mr. Empty?")
            })
        } else if message.characters.count > 20 {
            display(at: 2, with: "my name is the most longest name in the world")
            delay(delay: 3, closure: {
                self.speech("really, can you give me one brief name")
                self.showAssessment(with: " ### Type in a **valid** name😙", success: false)
                self.showForthSenctece(with: "really😂, can you give me one brief name")
            })
        } else {
            name = message
            display(at: 2, with: "my name is \(message)")
            delay(delay: 3, closure: {
                self.speech("Hello, \(message), how are you.")
                self.showForthSenctece(with: "Hello, \(message), how are you.")
            })
        }
            User.previousName = message
        }
    }
    
    func showForthSenctece(with message: String) {
        display(at: 3, with: message)
    }
    func showFifthSentence(_ bool: Bool) {
        if sentences[4].alpha != 0 {
            UIView.animate(withDuration: 0.7, animations: {
                self.sentences[4].alpha = 0.0
                self.sentences[5].alpha = 0.0
            })
        }
        func show() {
            //good mood
            if bool {
                display(at: 4, with: "fine😜")
                delay(delay: 2, closure: {
                    self.speech("haha, I hope you are happy everyday. Next page, I will show you more about me.")
                    self.showAssessment(with: "I hope you are happy eveyday.😁 \n\n[**Next Page**](@next)", success: true)
                })
            } else { //bad mood
                display(at: 4, with: "not good☹️")
                delay(delay: 3, closure: {
                    self.speech("That's OK. I build a Page that you can relax youself.")
                    self.showAssessment(with: "That's OK. I build a Page that you can relax youself. \n\nPlease navigate to [**LoveRainy**](LoveRainy) page.", success: false)
                })
            }
        }

        if sentences[3].alpha == 0 {
            delay(delay: 3, closure: {
                show()
            })
        } else {
            show()
        }
        
    }
    
    
    /// func that used to comunicate with Contents.swift
    ///
    /// - Parameters:
    ///   - message: the Assessment string
    ///   - success: true if is in good mood
    func showAssessment(with message: String, success: Bool) {
        let Dict: PlaygroundValue = .dictionary(["assessment": PlaygroundValue.string(message),
                    "mood": PlaygroundValue.boolean(success)])
        send(Dict)
    }
}

extension WelComeVC: PlaygroundLiveViewMessageHandler {
    public func receive(_ message: PlaygroundValue) {
        switch message {
        case let .boolean(bool):
            //true is in good mood
            showFifthSentence(bool)
            break
        case let .string(text):
            User.name = text
            showThirdSentence(with: text)
        default: break
        }
    }
}





