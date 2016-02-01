//
//  CourseTableViewController.swift
//  HAUS
//
//  Created by Chen Jin on 12/28/15.
//  Copyright © 2015 Chen Jin. All rights reserved.
//


import UIKit
//import Parse
//import ParseUI
//import Firebase


class CourseTableViewController: PFQueryTableViewController, UISearchBarDelegate {

@IBOutlet weak var searchBar: UISearchBar!

var ref: Firebase!
var arrayOfTitle: [String] = [String]()

// MARK: - Lifecycle
override func viewDidLoad() {
super.viewDidLoad()
}

override func viewDidAppear(animated: Bool) {
// Refresh the table to ensure any data changes are displayed
tableView.reloadData()

// Delegate the search bar to this table view class
searchBar.delegate = self

// Set up Firebase
ref = Firebase(url:"https://csa.firebaseio.com")
}

override func viewWillAppear(animated: Bool) {
loadObjects()
}

override func queryForTable() -> PFQuery {
let query = Course.query()

// Add a where clause if there is a search criteria
if searchBar.text != "" {
query!.whereKey("title", containsString: searchBar.text!.lowercaseString)
}

return query!
}

override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell? {

let cell = tableView.dequeueReusableCellWithIdentifier("courseCell", forIndexPath: indexPath) as! CourseTableViewCell

let course = object as! Course

var title: String = course.title!

cell.courseLabel.text = title

// Add course name to title list
if !arrayOfTitle.contains(title) {
arrayOfTitle.append(title)
}

return cell
}

override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
if (segue.identifier == "courseToChat") {


// Get the cell index for current cell
var selectedItems: [AnyObject] = self.tableView.indexPathsForSelectedRows!
var selectedItem: NSIndexPath = selectedItems[0] as! NSIndexPath
var selectedIndex: Int = selectedItem.row


// Get event name and detail URL for current cell
var courseTitle: String = arrayOfTitle[selectedIndex]

// Set destination view controller
//var chatView: CourseChatViewController = segue.destinationViewController as! CourseChatViewController
var chatView = segue.destinationViewController as! CourseChatViewController

// Pass data from current view controller to detail view controller
var user: PFUser = PFUser.currentUser()!

//chatView.titleString = courseTitle
//chatView.ref = ref
chatView.title = courseTitle
chatView.passValue = user.username!
chatView.ref = Firebase(url: "https://csa.firebaseio.com/" + courseTitle)
chatView.hidesBottomBarWhenPushed = true

//print("In prepareForSegue...")
//print(courseTitle)
//print(ref)
//print(user.username)

}
}

// Implement Search
func searchBarTextDidEndEditing(searchBar: UISearchBar) {

// Dismiss the keyboard
searchBar.resignFirstResponder()

// Force reload of table data
self.loadObjects()
}

func searchBarSearchButtonClicked(searchBar: UISearchBar) {

// Dismiss the keyboard
searchBar.resignFirstResponder()

// Force reload of table data
self.loadObjects()
}

func searchBarCancelButtonClicked(searchBar: UISearchBar) {

// Clear any search criteria
searchBar.text = ""

// Dismiss the keyboard
searchBar.resignFirstResponder()

// Force reload of table data
self.loadObjects()
}
}

