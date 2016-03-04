//
//  AssignedCameraTableViewController.swift
//  DahuApp
//
//  Created by Le Minh Tu on 2/21/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//

import UIKit

class AssignedCameraTableViewController: UITableViewController {
    
//    var cameras = [CameraView]()
//    var email: String = ""
    var cameras = [CameraObject]()
    var selectedUser = UserObject()
    var assignedCameras: [CameraObject]?
    var selectedIndexPath: NSIndexPath?
    
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBAction func btnSave(sender: AnyObject) {
        saveAssignedCameras()
        backToPrevious()
    }

    @IBAction func btnCancel(sender: AnyObject) {
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

        delegate.setupNavigation((self.navigationController?.navigationBar)!, titleName: "List Camera")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cameras.count
    }
    
    func saveAssignedCameras() {
        print("Save assigned cameras")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "cameraTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CameraTableViewCell
        
        let camera = cameras[indexPath.row]
        cell.cameraDescription.text = camera.name
        cell.switchOn.on = AppUtility.findCamera(assignedCameras!, whichCamera: camera)
        
        return cell
    }
    
    
    @IBAction func prepareForUnwindAssignedCameraView(sender: UIStoryboardSegue) {
        if let configDateController = sender.sourceViewController as? ConfigDateTableViewController {
            print("Unwind row: \(selectedIndexPath?.row)")
            cameras[(selectedIndexPath?.row)!] = configDateController.selectedCamera
        }
        
        delegate.setupNavigation((self.navigationController?.navigationBar)!, titleName: "List Camera")
    }


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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "setDateCameraSegue" {
            let configDateController = segue.destinationViewController as! ConfigDateTableViewController
            configDateController.selectedUser = selectedUser
            configDateController.selectedCamera = cameras[(tableView.indexPathForSelectedRow?.row)!]
            selectedIndexPath = tableView.indexPathForSelectedRow
        }
    }
    

}
