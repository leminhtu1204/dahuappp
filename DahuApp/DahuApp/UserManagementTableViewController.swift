//
//  UserManagementTableViewController.swift
//  DahuApp
//
//  Created by Le Minh Tu on 2/21/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//

import UIKit
import CoreData

class UserManagementTableViewController: UITableViewController {
    
    var loginUser = UserObject()
 //   var users = [NSManagedObject]();
    
//    func initialData(){
//        //1
//        let appDelegate =
//        UIApplication.sharedApplication().delegate as! AppDelegate
//        
//        let managedContext = appDelegate.managedObjectContext
//        
//        //2
//        let fetchRequest = NSFetchRequest(entityName: "UserProfile")
//        
//        //3
//        do {
//            let results =
//            try managedContext.executeFetchRequest(fetchRequest)
//            users = results as! [NSManagedObject]
//        } catch let error as NSError {
//            print("Could not fetch \(error), \(error.userInfo)")
//        }
//    }
    
    func deleteUser(index: Int){
//        let appDelegate =
//        UIApplication.sharedApplication().delegate as! AppDelegate
//        
//        let managedContext = appDelegate.managedObjectContext
//        managedContext.deleteObject(users[index] as NSManagedObject)
//        users.removeAtIndex(index)
//                
//        //3
//        do {
//            try managedContext.save()
//        } catch let error as NSError {
//            print("Could not fetch \(error), \(error.userInfo)")
//        }
        let selectedUser = loginUser.userList![index]
        
        let isSuccessfully = AppUtility.deleleUser(selectedUser.id!) as Bool
        print("Is user deleted? - \(isSuccessfully)")
        loginUser.userList?.removeAtIndex(index)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initialData()
        setupNavigation()
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
        return (loginUser.userList?.count)!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let user = loginUser.userList![indexPath.row]
        
        cell.textLabel!.text = user.fullName
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        /*
        print("Edit style")
        print(editingStyle)
        
        if editingStyle == .Delete {
        deleteUser(indexPath.row)
        // Delete the row from the data source
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        
        } else if editingStyle == .Insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        */
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .Normal, title: "Edit") { action, index in
            print(action)
            print(index)
            print("edit button tapped")
            let editUseViewController = self.storyboard?.instantiateViewControllerWithIdentifier("editUserViewController") as! UITableViewController
            self.navigationController?.pushViewController(editUseViewController, animated: true)
        }
        edit.backgroundColor = UIColor.blueColor()
        
        let delete = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in
            print(action)
            print(index)
            print("delete button tapped")
            self.deleteUser(indexPath.row)
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        delete.backgroundColor = UIColor.redColor()

        return [edit, delete]
    }


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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "assignCameras" {
//            print("Click to assign cameras")
//            let assignCameraTableViewController = segue.destinationViewController as! AssignedCameraTableViewController
//            
//            print(sender)
//            print("selected cell")
//            print(self.tableView.indexPathForSelectedRow?.row)
//            
//            if let selectedUserCell = sender as? UITableViewCell {
//                print("Click selected user to assign")
//                let indexPath = tableView.indexPathForCell(selectedUserCell)!
//                let selectedUser = users[indexPath.row]
//                print(selectedUser.valueForKey("email"))
//                assignCameraTableViewController.email = (selectedUser.valueForKey("email") as? String)!
//
//            }
//        }
//    
    }
    
    @IBAction func prepareForUnwind(sender: UIStoryboardSegue) {
    if let sourceViewController = sender.sourceViewController as? CreateUserTableViewController, user = sourceViewController.user {
//            if let selectedIndexPath = tableView.indexPathForSelectedRow {
//                // Update an existing meal.
//                users[selectedIndexPath.row] = user
//                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
//            } else {
//                // Add a new meal.
//                let newIndexPath = NSIndexPath(forRow: users.count, inSection: 0)
//                users.append(user)
//                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
//            }
        }
    }
    
    func setupNavigation(){
        self.navigationController!.navigationBarHidden = false;
        if let navigationBar = self.navigationController?.navigationBar {
            let titleFrame = CGRect(x: navigationBar.frame.width/4 + 50, y: 0, width: 200, height: 40)
            
            let imageView = UIImageView(frame: CGRect(x: navigationBar.frame.width/4, y: 0, width: 40, height: 40))
            imageView.contentMode = .ScaleAspectFit
            // 4
            let image = UIImage(named: "logo")
            imageView.image = image
            
            let title = UILabel(frame: titleFrame)
            title.text = "User Management"
            title.font = title.font.fontWithSize(17)

            navigationBar.addSubview(title)
            navigationBar.addSubview(imageView)
        }
    }

}
