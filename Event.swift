//
//  Event.swift
//  HAUS
//
//  Created by Chen Jin on 12/26/15.
//  Copyright © 2015 Chen Jin. All rights reserved.
//

import Foundation
//import Parse
//import ParseUI

class Event: PFObject, PFSubclassing {
    
    
    @NSManaged var name: String?
    @NSManaged var time: String?
    @NSManaged var address: String?
    @NSManaged var detail: String?
    @NSManaged var ticket: DarwinBoolean
    @NSManaged var image: PFFile
    
    
    init(name: String?, time: String?, address: String?, detail: String?,
        image: PFFile, ticket: DarwinBoolean){
            super.init()
            self.name = name
            self.time = time
            self.address = address
            self.detail = detail
            self.image = image
            self.ticket = ticket
    }
    
    override init() {
        super.init()
    }
    
    class func parseClassName() -> String {
        return "Event"
    }
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    override class func query() -> PFQuery? {
        let query = PFQuery(className: Event.parseClassName())
        query.orderByAscending("createdAt")
        return query
    }
    
}

