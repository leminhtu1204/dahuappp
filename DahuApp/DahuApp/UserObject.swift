//
//  UserObject.swift
//  DahuApp
//
//  Created by  Trung Trinh on 2/28/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//

import UIKit

class UserObject {
    var id: Int?
    var fullName: String
    var email: String
    var isAdmin: Bool
    var password: String
    
    init() {
        fullName = ""
        email = ""
        isAdmin = false
        password = ""
    }
    
    init(fullName: String, email: String, isAdmin: Bool, password: String) {
        self.fullName = fullName
        self.email = email
        self.isAdmin = isAdmin
        self.password = password
    }
    
    init(id: Int, fullName: String, email: String, isAdmin: Bool, password: String) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.isAdmin = isAdmin
        self.password = password
    }
}
