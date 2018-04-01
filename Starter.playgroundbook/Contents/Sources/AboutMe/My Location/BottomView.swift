//
//  BottomView.swift
//  AboutMe-3
//
//  Created by Hao Dong on 19/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit

class BottomView: UIView {
    
    var textView: UITextView!
    
    override init(frame: CGRect) {
        textView = UITextView()
        super.init(frame: frame)
        
        self.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        textView.textColor = UIColor.black.withAlphaComponent(0.5)
        textView.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        self.layer.shadowOffset = CGSize(width: 30, height: 30)
        self.layer.shadowRadius = 20
        textView.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
