//
//  ProfileViewController.swift
//  HAUS
//
//  Created by Chen Jin on 12/28/15.
//  Copyright © 2015 Chen Jin. All rights reserved.
//

import UIKit
//import Parse
//import ParseUI

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var profileImage: PFImageView!
    // User selected object
    var currentObject : PFObject?
    
    // Object to update
    var updateObject : PFObject?
    
    // Image Picker object
    var imagePicker = UIImagePickerController()
    var imageDidChange = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieving username
        var user: PFUser = PFUser.currentUser()!
        var usernameString = user.username
        
        // Substring username to make nickname
        if let range = usernameString!.rangeOfString("@usc.edu") {
            var firstPart = usernameString!.substringToIndex(range.startIndex)
            nicknameLabel.text = firstPart.lowercaseString
        }
        
        // Retriving user profile picture
        if let userPicture = PFUser.currentUser()?["picture"] as? PFFile {
            userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    self.profileImage.image = UIImage(data:imageData!)
                }
            }
        }
    }
    
    
    @IBAction func uploadImageAction(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .PhotoLibrary
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    // Process selected image - add image to the parse object model
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            // Update the image within the app interface
            profileImage.image = pickedImage
            profileImage.contentMode = .ScaleAspectFit
            
            // Update the image did change flag so that we pick this up when save image back to Parse
            imageDidChange = true
        }
        
        // Dismiss the image picker
        dismissViewControllerAnimated(true, completion: nil)
        
        // Upload the profile image
        if imageDidChange == true {
            /*
            let imageData = UIImagePNGRepresentation(profileImage.image)
            let fileName = nicknameLabel.text! + "Image.png"
            let imageFile = PFFile(name:fileName, data:imageData)
            imageFile.saveInBackground()
            var user: PFUser = PFUser.currentUser()!
            user.setObject(imageFile, forKey: "pciture")
            user.saveInBackground()
            */
            
            
            let imageData = UIImagePNGRepresentation(profileImage.image!)
            let fileName = nicknameLabel.text! + "Image.png"
            let imageFile = PFFile(name:fileName, data:imageData!)
            
            var user = PFUser.currentUser()!
            user["picture"] = imageFile
            user.saveInBackground()
            
        }
    }
    
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutAction(sender: AnyObject) {
        
        PFUser.logOut()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("LoginViewController")
        self.presentViewController(vc, animated: true, completion: nil)
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

