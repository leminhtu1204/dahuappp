//
//  EditUserTableViewController.swift
//  DahuApp
//
//  Created by  Trung Trinh on 3/2/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//

import UIKit

class EditUserTableViewController: UITableViewController {
    var editingUser = UserObject()

    @IBOutlet weak var fullNametxt: UITextField!
    @IBOutlet weak var newPasswordTxt: UITextField!
    @IBOutlet weak var isAdminSwitch: UISwitch!
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBAction func cancelEditUser(sender: AnyObject) {
        backToPrevious()
    }
    
    @IBAction func saveEditUser(sender: AnyObject) {
        editingUser.fullName = fullNametxt.text!
        editingUser.password = newPasswordTxt.text!
        editingUser.isAdmin = isAdminSwitch.on
        
        let result = AppUtility.editUser(editingUser)
        print("Edit user - Result code: \(result)")
        
        backToPrevious()
    }
    
    func backToPrevious(){
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate.setupNavigation((self.navigationController?.navigationBar)!, titleName: "Edit User")
        fullNametxt.text = editingUser.fullName
        isAdminSwitch.on = editingUser.isAdmin
        newPasswordTxt.text = editingUser.password
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
