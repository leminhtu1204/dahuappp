//
//  AppUtility.swift
//  DahuApp
//
//  Created by  Trung Trinh on 2/28/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//

import Foundation
import Alamofire

class AppUtility {
    
    /*
    JSON: {
        code = 0;
        data =     {
            CameraDetail = (
                {
                    camId = 1;
                    camLink = "rtsp://admin:admin@wagington.ddns.net:5101/live";
                    camName = "W101 Main Entrance";
                    cuFrom = "2016-02-26";
                    cuTo = "2016-02-29";
                },
                {
                    camId = 2;
                    camLink = "rtsp://admin:admin@wagington.ddns.net:5102/live";
                    camName = "W102 Feline Entrance Area";
                    cuFrom = "<null>";
                    cuTo = "<null>";
                }
            );
            UserDetail = {
                FullName = "Viet Nam";
                email = "khongminhphong@gmail.com2";
                id = 1;
                isAdmin = 0;
                password = 123456;
            };
        };
    }
    */
    class func parseToUserObject(json: AnyObject) -> UserObject {
        let userObject = UserObject()
        
        if let code = json["code"] as? String {
            if code == "-1" {
                print("Wrong email or password")
                return userObject
            }
        }
        
        if let data = json["data"] as? NSDictionary {
            
            // UserDetail
            if let userDetail = data.valueForKey("UserDetail") as? NSDictionary {
                if let fullName = userDetail.valueForKey("FullName") as? String {
                    userObject.fullName = fullName
                }
                
                if let email = userDetail.valueForKey("email") as? String {
                    userObject.email = email
                }
                
                if let id = userDetail.valueForKey("id") as? String {
                    if let idInt = Int(id) {
                        userObject.id = idInt
                    }
                    
                }

                if let isAdmin = userDetail.valueForKey("isAdmin") as? String {
                    if isAdmin == "0" {
                        userObject.isAdmin = false
                    } else {
                        userObject.isAdmin = true
                    }
                }

                if let password = userDetail.valueForKey("password") as? String {
                    userObject.password = password
                }
            }
            
            // CameraDetail
            if let cameras = data.valueForKey("Camera") as? NSArray {
                if cameras.count > 0 {
                    userObject.cameras = [CameraObject]()
                }
                
                for camera in cameras {
                    let newCamera = CameraObject()
                    if let name = camera.valueForKey("name") as? String {
                        newCamera.name = name
                    }
                    
                    if let id = camera.valueForKey("id") as? String {
                        if let idInt = Int(id) {
                            newCamera.id = idInt
                        }

                    }
                    
                    if let link = camera.valueForKey("link") as? String {
                        newCamera.link = link
                    }

//                    if let fromDate = camera.valueForKey("cuFrom") as? String {
//                        newCamera.fromDate = CameraObject.parseStringToDate(fromDate)
//                    }
//
//                    if let toDate = camera.valueForKey("cuTo") as? String {
//                        newCamera.toDate = CameraObject.parseStringToDate(toDate)
//                    }

                    userObject.cameras?.append(newCamera)
                }
            }
            
            
            // UserList
            if let userList = data.valueForKey("UserList") as? NSArray {
                if userList.count > 0 {
                    userObject.userList = [UserObject]()
                }
                
                for user in userList {
                    let newUser = UserObject()
                    if let name = user.valueForKey("fullName") as? String {
                        newUser.fullName = name
                    }
                    
                    if let email = user.valueForKey("email") as? String {
                        newUser.email = email
                    }
                    
                    if let id = user.valueForKey("id") as? String {
                        if let idInt = Int(id) {
                            newUser.id = idInt
                        }
                    }
                    
                    if let isAdmin = user.valueForKey("isAdmin") as? String {
                        if isAdmin == "0" {
                            newUser.isAdmin = false
                        } else {
                            newUser.isAdmin = true
                        }

                    }
                    
                    if let password = user.valueForKey("password") as? String {
                        newUser.password = password
                    }
                    
                    userObject.userList?.append(newUser)
                }
            }
        }
        
        return userObject
    }
    
    class func parseToCameraObjects(json: AnyObject) -> [CameraObject]? {

        var cameras =  [CameraObject]()
        
        if let cameraList = json["data"] as? [AnyObject] {
            for cam in cameraList {
                let camera = CameraObject()
                if let camId = cam.valueForKey("camId") as? String {
                    if let camIdInt = Int(camId) {
                        camera.id = camIdInt
                    }
                }
                
                if let name = cam.valueForKey("camName") as? String {
                    camera.name = name
                }
                
                if let link = cam.valueForKey("camLink") as? String {
                    camera.link = link
                }
                
                if let fromDate = cam.valueForKey("cuFrom") as? String {
                    camera.fromDate = CameraObject.parseStringToDate(fromDate)
                }
                
                if let toDate = cam.valueForKey("cuTo") as? String {
                    camera.toDate = CameraObject.parseStringToDate(toDate)
                }

                cameras.append(camera)
            }
        }
        
        return cameras
    }
    
    class func loginUser(user: String, pass: String) -> UserObject {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        var userObject = UserObject()
        
        let semaphore = dispatch_semaphore_create(0)
        
        Alamofire.request(.POST, "http://chiasehosting.org/dahua/index.php", parameters: ["action": "login", "email": "\(user)", "password": "\(pass)"], headers: headers)
            .responseJSON { response in
                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
                    userObject = parseToUserObject(JSON)
                    dispatch_semaphore_signal(semaphore)
                }
        }
        
        // waiting for the resquest to complete
        while dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW) != 0 {
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 10))
        }
        
        return userObject
    }
    
    class func deleleUser(id: Int) -> Bool {
        var isSuccessfully: Bool
        isSuccessfully = true
        
        let semaphore = dispatch_semaphore_create(0)
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        Alamofire.request(.POST, "http://chiasehosting.org/dahua/index.php", parameters: ["action": "deleteuser", "id": "\(id)"], headers: headers)
            .responseJSON { response in
                if let JSON = response.result.value {
                    if let code = JSON["code"] as? String {
                        if code == "1" {
                            isSuccessfully = true
                        } else {
                            isSuccessfully = false
                        }
                    }
                    dispatch_semaphore_signal(semaphore)
                }
        }
        
        // waiting for the resquest to complete
        while dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW) != 0 {
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 10))
        }
        
        return isSuccessfully
    }
    
    class func addUser(newUser: UserObject) -> Int {
        var newId: Int
        newId = -1
        
        let semaphore = dispatch_semaphore_create(0)
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        var isAdmin = 0
        if newUser.isAdmin==true {
            isAdmin = 1
        }
        
        Alamofire.request(.POST, "http://chiasehosting.org/dahua/index.php", parameters: ["action": "adduser", "email": "\(newUser.email)", "password": "\(newUser.password)"
            ,"fullName": "\(newUser.fullName)", "isAdmin": "\(isAdmin)"], headers: headers)
            .responseJSON { response in
                if let JSON = response.result.value {
                    if let data = JSON.valueForKey("data") as? NSDictionary {
                        if let userDetail = data.valueForKey("UserDetail") as? NSDictionary {
                            if let id = userDetail.valueForKey("id") as? String {
                                if let idInt = Int(id) {
                                    newId = idInt
                                }
                            }
                        }
                    }
                    dispatch_semaphore_signal(semaphore)
                }
        }
        
        // waiting for the resquest to complete
        while dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW) != 0 {
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 10))
        }
        
        return newId
    }
    
    class func editUser(editingUser: UserObject) -> Int {
        var code: Int
        code = -1
        let semaphore = dispatch_semaphore_create(0)
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        var isAdmin = 0
        if editingUser.isAdmin==true {
            isAdmin = 1
        }
        
        let idString = editingUser.id != nil ? "\(editingUser.id!)" : ""
        
        Alamofire.request(.POST, "http://chiasehosting.org/dahua/index.php", parameters: ["action": "updateuser",
            "email": "\(editingUser.email)",
            "password": "\(editingUser.password)",
            "fullName": "\(editingUser.fullName)",
            "isAdmin": "\(isAdmin)",
            "id": "\(idString))"
            ], headers: headers)
            .responseJSON { response in
                if let JSON = response.result.value {
                    print(JSON)
                    if let result = JSON["code"] as? String {
                        code = Int(result)!
                    }
                
                    dispatch_semaphore_signal(semaphore)
                }
        }
        
        // waiting for the resquest to complete
        while dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW) != 0 {
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 10))
        }
        
        return code
    }
    
    class func getAssignedCameras(editingUser: UserObject) -> [CameraObject]? {
        var cameras: [CameraObject]?
        let semaphore = dispatch_semaphore_create(0)
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let idString = editingUser.id != nil ? "\(editingUser.id!)" : ""
        
        Alamofire.request(.POST, "http://chiasehosting.org/dahua/index.php", parameters: ["action": "getcams","id": "\(idString))"], headers: headers)
            .responseJSON { response in
                if let JSON = response.result.value {
                    print(JSON)
                    cameras = parseToCameraObjects(JSON)
                    
                    dispatch_semaphore_signal(semaphore)
                }
        }
        
        // waiting for the resquest to complete
        while dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW) != 0 {
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 10))
        }
        
        return cameras
    }

    class func findCamera(cameraList: [CameraObject], whichCamera: CameraObject) -> Bool {
        for camera in cameraList {
            if whichCamera.id == camera.id {
                return true
            }
        }
        return false
    }
}
