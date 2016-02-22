//
//  UserProfile+CoreDataProperties.swift
//  DahuApp
//
//  Created by Le Minh Tu on 2/21/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension UserProfile {

    @NSManaged var createdDate: NSDate?
    @NSManaged var email: String?
    @NSManaged var fullname: String?
    @NSManaged var password: String?
    @NSManaged var user_camera: NSSet?

}
