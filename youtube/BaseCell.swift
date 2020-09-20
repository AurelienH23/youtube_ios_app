//
//  BaseCell.swift
//  youtube
//
//  Created by Aurélien Haie on 05/01/2017.
//  Copyright © 2017 Aurélien Haie. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    func setUpViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
