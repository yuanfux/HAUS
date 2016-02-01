//
//  EventTableViewController.swift
//  HAUS
//
//  Created by Chen Jin on 12/28/15.
//  Copyright © 2015 Chen Jin. All rights reserved.
//

import UIKit
//import Parse
//import ParseUI


class EventTableViewController: PFQueryTableViewController {
    
    
    var arrayOfDetail: [String] = [String]()
    var arrayOfName: [String] = [String]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        loadObjects()
    }
    
    override func queryForTable() -> PFQuery {
        let query = Event.query()
        return query!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell? {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventTableViewCell
        
        let event = object as! Event
        
        var name: String = event.name!
        var time: String = event.time!
        var address: String = event.address!
        var detail: String = event.detail!
        
        cell.nameLabel.text = name
        cell.timeLabel.text = time
        cell.addressLabel.text = address
        
        cell.eventImage.file = event.image
        cell.eventImage.loadInBackground(nil)
        
        // Add event name to name list
        if !arrayOfName.contains(name) {
            arrayOfName.append(name)
        }
        
        // Add event detail to detail list
        if !arrayOfDetail.contains(detail) {
            arrayOfDetail.append(detail)
        }
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "eventDetail") {
            
            // Get the cell index for current cell
            var selectedItems: [AnyObject] = self.tableView.indexPathsForSelectedRows!
            var selectedItem: NSIndexPath = selectedItems[0] as! NSIndexPath
            var selectedIndex: Int = selectedItem.row
            
            // Get event name and detail URL for current cell
            var eventName: String = arrayOfName[selectedIndex]
            var eventDetail: String = arrayOfDetail[selectedIndex]
            
            // Set destination view controller
            var detailView: EventDetailViewController = segue.destinationViewController as! EventDetailViewController
            
            // Pass data from current view controller to detail view controller
            detailView.nameString = eventName
            detailView.detailString = eventDetail
            
        }
    }
    
    
}

