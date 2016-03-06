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
    var fromDate: NSDate?
    var toDate: NSDate?

    init() {
        id = 0
        link = ""
        name = ""
        fromDate = nil
        toDate = nil
    }
    
    init(id: Int, link: String, name: String, fromDate: NSDate?, toDate: NSDate?) {
        self.id = id
        self.link = link
        self.name = name
        self.fromDate = fromDate
        self.toDate = toDate
    }
    
    class func parseStringToDate(stringDate: String?) -> NSDate? {
        if stringDate == nil {
            return nil
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.dateFromString(stringDate!)

    }
    
    class func parseDateToString(date: NSDate?) -> String? {
        if date == nil {
            return ""
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        
        return dateFormatter.stringFromDate(date!)
    }
}
