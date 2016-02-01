//
//  LoginViewController.swift
//  HAUS
//
//  Created by Chen Jin on 12/26/15.
//  Copyright © 2015 Chen Jin. All rights reserved.
//


import UIKit
//import Parse
//import ParseUI

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func loginAction(sender: AnyObject) {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        
        //var userEmailAddress = emailText.text + "@usc.edu"
        var userEmailAddress = emailText.text
        userEmailAddress = userEmailAddress!.lowercaseString
        
        var userPassword = passwordText.text
        
        PFUser.logInWithUsernameInBackground(userEmailAddress!, password:userPassword!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("loginToMain", sender: self)
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
    
    @IBAction func signupAction(sender: AnyObject) {
        
        self.performSegueWithIdentifier("loginToSignup", sender: self)
        
    }
    
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
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

