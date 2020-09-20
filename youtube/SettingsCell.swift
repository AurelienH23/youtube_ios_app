//
//  SettingsCell.swift
//  youtube
//
//  Created by Aurélien Haie on 06/01/2017.
//  Copyright © 2017 Aurélien Haie. All rights reserved.
//

import UIKit

class SettingsCell: BaseCell {
    //MARK: Properties
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            
            if let imageName = setting?.imageName {
                imageView.image = UIImage(named: imageName)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                imageView.contentMode = .scaleAspectFill
                imageView.tintColor = UIColor.gray
            }
        }
    }
    
    //MARK: View elements
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_settings")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = UIColor.gray
        return imageView
    }()
    
    //MARK: Setup func
    override func setUpViews() {
        super.setUpViews()
        addSubview(nameLabel)
        addSubview(imageView)
        
        addConstraintWithFormat(format: "H:|-16-[v0(30)]-8-[v1]|", views: imageView, nameLabel)
        addConstraintWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintWithFormat(format: "V:|-10-[v0(30)]-10-|", views: imageView)
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.lightGray : UIColor.white
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.gray
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
        }
    }
}
