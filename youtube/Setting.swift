//
//  Setting.swift
//  youtube
//
//  Created by Aurélien Haie on 06/01/2017.
//  Copyright © 2017 Aurélien Haie. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
