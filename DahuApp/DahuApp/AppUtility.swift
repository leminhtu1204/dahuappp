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
        
        // UserDetail
        if let data = json["data"] as? NSDictionary {
            if let userDetail = data.valueForKey("UserDetail") as? NSDictionary {
                if let fullName = userDetail.valueForKey("FullName") as? String {
                    print(fullName)
                    userObject.fullName = fullName
                }
                
                if let email = userDetail.valueForKey("email") as? String {
                    print(email)
                    userObject.email = email
                }
                
                if let id = userDetail.valueForKey("id") as? String {
                    print(id)
                    if let idInt = Int(id) {
                        userObject.id = idInt
                    }
                    
                }

                if let isAdmin = userDetail.valueForKey("isAdmin") as? String {
                    print(isAdmin)
                    if isAdmin == "0" {
                        userObject.isAdmin = false
                    } else {
                        userObject.isAdmin = true
                    }
                }

                if let password = userDetail.valueForKey("password") as? String {
                    print(password)
                    userObject.password = password
                }
            }
            
        }
        
        // CameraDetail
    
        print("User in parse to object: \(userObject.email)")
        return userObject
    }
    
    class func loginUser(user: String, pass: String) -> UserObject {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        var userObject = UserObject()
        
        Alamofire.request(.POST, "http://chiasehosting.org/dahua/index.php", parameters: ["action": "login", "email": "\(user)", "password": "\(pass)"], headers: headers)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                //                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
                    userObject = parseToUserObject(JSON)
                    print("User email in response: \(userObject.email)")
                }
        }
        
        print("User email in login User: \(userObject.email)")
        return userObject
    }
    
}
