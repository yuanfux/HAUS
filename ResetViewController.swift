//
//  ResetViewController.swift
//  HAUS
//
//  Created by Chen Jin on 12/26/15.
//  Copyright © 2015 Chen Jin. All rights reserved.
//

import UIKit
//import Parse
//import ParseUI

class ResetViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetAction(sender: AnyObject) {
        //var userEmailAddress = emailText.text + "@usc.edu"
        var userEmailAddress = emailText.text
        userEmailAddress = userEmailAddress!.lowercaseString
        PFUser.requestPasswordResetForEmailInBackground(userEmailAddress!)
        
        var alert = UIAlertView(title: "Password Reset", message: "An Email with reset instructions has been sent to " + userEmailAddress!,
            delegate: self, cancelButtonTitle: "OK")
        alert.show()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

