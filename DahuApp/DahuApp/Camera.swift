//
//  Camera.swift
//  DahuApp
//
//  Created by  Trung Trinh on 2/23/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//

import UIKit

class Camera {
    var switchOn: Bool
    var description: String
    
    init() {
        self.switchOn = false
        self.description = "defaul_description"
    }
    
    init(switchOn: Bool, description: String) {
        self.switchOn = switchOn
        self.description = description
    }
}
