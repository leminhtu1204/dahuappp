//
//  ConfigDateTableViewController.swift
//  DahuApp
//
//  Created by Le Minh Tu on 2/21/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//

import UIKit

class ConfigDateTableViewController: UITableViewController {
    var selectedUser = UserObject()
    var selectedCamera = CameraObject()
    
    @IBOutlet weak var btnSaveDate: UIBarButtonItem!
    @IBOutlet weak var fromDateSwitch: UISwitch!
    @IBOutlet weak var toDateSwitch: UISwitch!
    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    
    @IBAction func btnCancel(sender: AnyObject) {
        print("cancel set date")
        backToPrevious()
    }
    
    @IBAction func saveDate(sender: AnyObject) {
        print(fromDateSwitch.on)
        print(fromDatePicker.date)
        print(toDateSwitch.on)
        print(toDatePicker.date)
        
        if fromDateSwitch.on {
            selectedCamera.fromDate = fromDatePicker.date
        }
        
        if toDateSwitch.on {
            selectedCamera.toDate = toDatePicker.date
        }
        
        backToPrevious()
    }
    
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate

    
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
        delegate.setupNavigation((self.navigationController?.navigationBar)!, titleName: "Camera Setup")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        print("Selected User: \(selectedUser.fullName)")
        print("Selected camera: \(selectedCamera.name)")
        print("From Date: \(selectedCamera.fromDate)")
        print("To Date: \(selectedCamera.toDate)")

        
        if selectedCamera.fromDate != nil {
            fromDateSwitch.on = true
            fromDatePicker.date = selectedCamera.fromDate!
        }
        
        if selectedCamera.toDate != nil {
            toDateSwitch.on = true
            toDatePicker.date = selectedCamera.toDate!
        }

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
        return 4
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if btnSaveDate === sender {
            print(fromDateSwitch.on)
            print(fromDatePicker.date)
            print(toDateSwitch.on)
            print(toDatePicker.date)

            if fromDateSwitch.on {
                selectedCamera.fromDate = fromDatePicker.date
            }
            
            if toDateSwitch.on {
                selectedCamera.toDate = toDatePicker.date
            }
        }

    }
    

}
