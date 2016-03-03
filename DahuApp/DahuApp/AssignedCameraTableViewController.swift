//
//  AssignedCameraTableViewController.swift
//  DahuApp
//
//  Created by Le Minh Tu on 2/21/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//

import UIKit

class AssignedCameraTableViewController: UITableViewController {
    
    var cameras = [CameraView]()
    var email: String = ""
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBAction func btnSave(sender: AnyObject) {
        print("Save for email: ")
        print(email)
        
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
        loadSampleCameras()
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
        print("Camera count: \(cameras.count)")
        return cameras.count
    }
    
    func saveAssignedCameras() {
        // reset the assigned cameras
        
        // save new assigned cameras
        for index in 0...cameras.count-1 {
            let cameraCell = tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: index, inSection: 0)) as! CameraTableViewCell
            if cameraCell.switchOn.on {
                print("Save this camera: ")
                print(cameras[index].description)
                cameras[index].save()
            }
        }
    }
    
    func loadSampleCameras() {
        print("Load sample cameras")
        cameras = [CameraView]()
        
        let camera1 = CameraView(switchOn: false, description: "Camera 1", url: "nhaccuatui.com", user_email_owner: email)
        let camera2 = CameraView(switchOn: false, description: "Camera 2", url: "nhaccuatui.com", user_email_owner: email)
        let camera3 = CameraView(switchOn: false, description: "Camera 3", url: "nhaccuatui", user_email_owner: email)
        
        cameras += [camera1, camera2, camera3]
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "cameraTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CameraTableViewCell
        
        let camera = cameras[indexPath.row]
        
        cell.switchOn.on = camera.switchOn
        cell.cameraDescription.text = camera.description
        
        print("Camera count: \(cameras.count) Camera: \(camera.description)")

        return cell
    }
    
    
    @IBAction func prepareForUnwindAssignedCameraView(sender: UIStoryboardSegue) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
