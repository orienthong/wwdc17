//
//  CustomCell.swift
//  AboutMe-3
//
//  Created by Hao Dong on 27/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    
    var imageView: UIImageView!
    var textView: UITextView!
    var loveButton: UIButton!
    //var detailButton: UIButton!
    
    override init(frame: CGRect) {
        imageView = UIImageView()
        textView = UITextView()
        loveButton = UIButton(type: .custom)
        //detailButton = UIButton(type: .custom)
        super.init(frame: frame)
        
        backgroundView = UIView()
        backgroundView!.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        backgroundView!.layer.cornerRadius = 5.0
        
        // setUp buttons
        contentView.addSubview(loveButton)
        loveButton.setImage(UIImage(named: "CTA1.png"), for: .normal)
        loveButton.translatesAutoresizingMaskIntoConstraints = false
        loveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        loveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        loveButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        loveButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
//        contentView.addSubview(detailButton)
//        detailButton.setImage(UIImage(named: "CTA2.png"), for: .normal)
//        detailButton.translatesAutoresizingMaskIntoConstraints = false
//        detailButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
//        detailButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
//        detailButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
//        detailButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        //setUp textView
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textColor = #colorLiteral(red: 0.6666017771, green: 0.6667135358, blue: 0.6665779948, alpha: 1)
        textView.isUserInteractionEnabled = false
        contentView.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 104).isActive = true
        textView.bottomAnchor.constraint(equalTo: loveButton.topAnchor, constant: -8).isActive = true
        
        //setUp ImageView
        imageView.contentMode = .scaleAspectFill
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5.0
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -8).isActive = true
        
        //contentView.addSubview(textLabel)
        //textLabel.translatesAutoresizingMaskIntoConstraints = false
        //textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        //textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 50)
        self.layer.shadowRadius = 50
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
//    let colors = [
//        DotColors(first: #colorLiteral(red: 0.4901960784, green: 0.7607843137, blue: 0.9568627451, alpha: 1), second: #colorLiteral(red: 0.8862745098, green: 0.1490196078, blue: 0.3019607843, alpha: 1)),
//        DotColors(first: #colorLiteral(red: 0.9725490196, green: 0.8, blue: 0.3803921569, alpha: 1), second: #colorLiteral(red: 0.6078431373, green: 0.8745098039, blue: 0.7294117647, alpha: 1)),
//        DotColors(first: #colorLiteral(red: 0.6862745098, green: 0.5647058824, blue: 0.9568627451, alpha: 1), second: #colorLiteral(red: 0.5647058824, green: 0.8196078431, blue: 0.9764705882, alpha: 1)),
//        DotColors(first: #colorLiteral(red: 0.9137254902, green: 0.662745098, blue: 0.4, alpha: 1), second: #colorLiteral(red: 0.9725490196, green: 0.7843137255, blue: 0.3215686275, alpha: 1)),
//        DotColors(first: #colorLiteral(red: 0.9647058824, green: 0.5607843137, blue: 0.6549019608, alpha: 1), second: #colorLiteral(red: 0.9647058824, green: 0.6352941176, blue: 0.7215686275, alpha: 1))
//    ]
//    
//    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
//        
//    }
//    
//    func faveButtonDotColors(_ faveButton: FaveButton) -> [DotColors]? {
//        return colors
//    }
    
    
}
