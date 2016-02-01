//
//  EventDetailViewController.swift
//  HAUS
//
//  Created by Chen Jin on 12/28/15.
//  Copyright © 2015 Chen Jin. All rights reserved.
//

import UIKit
//import Parse
//import ParseUI

class EventDetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailWebView: UIWebView!
    
    var nameString: String?
    var detailString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set detail controller title
        self.title = nameString
        
        // Load detail web view
        let requestURL = NSURL(string: detailString!)
        let request = NSURLRequest(URL: requestURL!)
        detailWebView.loadRequest(request)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
