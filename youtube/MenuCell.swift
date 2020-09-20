//
//  MenuCell.swift
//  youtube
//
//  Created by Aurélien Haie on 05/01/2017.
//  Copyright © 2017 Aurélien Haie. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    //MARK: Model population
    let images = ["ic_home", "ic_whatshot", "ic_subscriptions", "ic_person"]
    
    //MARK: View elements
    let imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    
    //MARK: Setup func
    override func setUpViews() {
        super.setUpViews()
        
        addSubview(imageView)
        addConstraintWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintWithFormat(format: "V:[v0(28)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    //MARK: Additional funcs
    override var isSelected: Bool {
        didSet {
            let selectedImage = "\(images[tag])_white"
            imageView.image = isSelected ? UIImage(named: selectedImage) : UIImage(named: images[tag])
        }
    }
}
