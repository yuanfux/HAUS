//
//  Sponsor.swift
//  HAUS
//
//  Created by Chen Jin on 12/26/15.
//  Copyright © 2015 Chen Jin. All rights reserved.
//

import Foundation
//import Parse
//import ParseUI

class Sponsor: PFObject, PFSubclassing {
    
    @NSManaged var name: String?
    @NSManaged var benefit: String?
    @NSManaged var address: String?
    @NSManaged var image: String?
    
    
    init(name: String?, benefit: String?, address: String?, image: String?) {
        super.init()
        self.name = name
        self.benefit = benefit
        self.address = address
        self.image = image
    }
    
    override init() {
        super.init()
    }
    
    class func parseClassName() -> String {
        return "Sponsor"
    }
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    override class func query() -> PFQuery? {
        let query = PFQuery(className: Sponsor.parseClassName())
        query.orderByDescending("createdAt")
        return query
    }
    
}