//
//  Course.swift
//  HAUS
//
//  Created by Chen Jin on 12/26/15.
//  Copyright © 2015 Chen Jin. All rights reserved.
//

import Foundation
//import Parse
//import ParseUI

class Course: PFObject, PFSubclassing {
    
    @NSManaged var title: String?
    
    
    init(title: String?){
        super.init()
        self.title = title
    }
    
    override init() {
        super.init()
    }
    
    class func parseClassName() -> String {
        return "Course"
    }
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    override class func query() -> PFQuery? {
        let query = PFQuery(className: Course.parseClassName())
        query.orderByAscending("createdAt")
        return query
    }
    
}
