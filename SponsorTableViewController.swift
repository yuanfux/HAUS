//
//  SponsorTableViewController.swift
//  HAUS
//
//  Created by Chen Jin on 12/28/15.
//  Copyright © 2015 Chen Jin. All rights reserved.
//

import UIKit
//import Parse
//import ParseUI

class SposnorTableViewController: PFQueryTableViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        loadObjects()
    }
    
    override func queryForTable() -> PFQuery {
        let query = Sponsor.query()
        return query!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell? {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("sponsorCell", forIndexPath: indexPath) as! SponsorTableViewCell
        
        let sponsor = object as! Sponsor
        
        cell.nameLabel.text = sponsor.name
        cell.benefitLabel.text = sponsor.benefit
        cell.addressLabel.text = sponsor.address
        
        // Upload image
        var urlString: String? = sponsor.image
        
        if var url: NSURL? = NSURL(string: urlString!) {
            var error: NSError?
            var request: NSURLRequest = NSURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 5.0)
            NSOperationQueue.mainQueue().cancelAllOperations()
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {
                (response: NSURLResponse?, imageData: NSData?, error: NSError?) -> Void in
                cell.sponsorImage.image = UIImage(data: imageData!)
            })
        }
        
        return cell
    }
    
}

