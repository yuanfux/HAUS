//
//  SignupViewController.swift
//  HAUS
//
//  Created by Chen Jin on 12/26/15.
//  Copyright © 2015 Chen Jin. All rights reserved.
//

import UIKit
//import Parse
//import ParseUI

class SignupViewController: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var emailText: UITextField!
    
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        activityIndicator.hidden = true
        activityIndicator.hidesWhenStopped = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signupAction(sender: AnyObject) {
        
        //var userEmailAddress = emailText.text + "@usc.edu"
        var userEmailAddress = emailText.text
        var userPassword = passwordText.text
        
        // Ensure username is lowercase
        userEmailAddress = userEmailAddress!.lowercaseString
        
        // Add email address validation
        
        if ( userPassword!.utf16.count < 5) {
            var alert = UIAlertView(title: "Invalid", message: "Password must be greater than 5 characters",
                delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else {
            
            // Start activity indicator
            activityIndicator.hidden = false
            activityIndicator.startAnimating()
            
            // Create the user
            var user = PFUser()
            user.username = userEmailAddress
            user.password = userPassword
            user.email = userEmailAddress
            
            var profile: UIImage = UIImage(named: "csaProfile")!
            let imageData = UIImagePNGRepresentation(profile)
            let fileName = userEmailAddress! + "Image.png"
            let imageFile = PFFile(name:fileName, data:imageData!)
            user["picture"] = imageFile
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if error == nil {
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("signupToMain", sender: self)
                    }
                    
                } else {
                    
                    self.activityIndicator.stopAnimating()
                    
                    if let message: AnyObject = error!.userInfo["error"] {
                        var alert = UIAlertView(title: "Error", message: "\(message)",
                            delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                    }
                }
            }
        }
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

