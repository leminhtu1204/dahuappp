//
//  Camera+CoreDataProperties.swift
//  DahuApp
//
//  Created by  Trung Trinh on 2/25/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Camera {

    @NSManaged var cameraDiscription: String?
    @NSManaged var url: String?

}
