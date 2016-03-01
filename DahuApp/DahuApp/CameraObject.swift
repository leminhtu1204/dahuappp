//
//  CameraObject.swift
//  DahuApp
//
//  Created by  Trung Trinh on 3/1/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//

import UIKit

class CameraObject {
    var id: Int
    var link: String
    var name: String
    var fromDate: String
    var toDate: String

    init() {
        id = 0
        link = ""
        name = ""
        fromDate = ""
        toDate = ""
    }
    
    init(id: Int, link: String, name: String, fromDate: String, toDate: String) {
        self.id = id
        self.link = link
        self.name = name
        self.fromDate = fromDate
        self.toDate = toDate
    }
}
