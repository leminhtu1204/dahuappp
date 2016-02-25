//
//  CameraView.swift
//  DahuApp
//
//  Created by  Trung Trinh on 2/23/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//

import UIKit
import CoreData

class CameraView {
    var switchOn: Bool
    var description: String
    var url: String
    var user_email_owner: String
    
    init() {
        self.switchOn = false
        self.description = "defaul_description"
        self.url = "nhaccuatui.com"
        self.user_email_owner = "admin"
    }
    
    init(switchOn: Bool, description: String, url: String, user_email_owner: String) {
        self.switchOn = switchOn
        self.description = description
        self.url = url
        self.user_email_owner = user_email_owner
    }
    
    func save() {
        print("Save to database")
        
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        let entityCamera = NSEntityDescription.entityForName("Camera", inManagedObjectContext: context)
        let newCamera = Camera(entity: entityCamera!, insertIntoManagedObjectContext: context)

        newCamera.setValue(description, forKey: "cameraDiscription")
        newCamera.setValue(url, forKey: "url")
        
        // Create Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "UserProfile")
        
        // Add Sort Descriptor
        let sortDescriptor = NSSortDescriptor(key: "email", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Execute Fetch Request
        do {
            let result = try context.executeFetchRequest(fetchRequest)
            
            for user in result {
                if user.valueForKey("email") as? String == user_email_owner {
                    
                    user.setValue(NSSet(object: newCamera), forKey: "user_camera")
                    do {
                        try user.managedObjectContext?.save()
                        print("Assign camera to user - DONE")
                    } catch {
                        let saveError = error as NSError
                        print(saveError)
                    }
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
    }
}
