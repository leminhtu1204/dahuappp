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
    let searchController = UISearchController(searchResultsController: nil)
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var filterCamera = [CameraObject]()
    
    @IBAction func switchOnCamera(sender: AnyObject) {
        let view = sender.superview!
        let cell = view!.superview as! CameraTableViewCell
        
        let indexPath = tableView.indexPathForCell(cell)
        print(indexPath?.row)
        
        //TODO: add this camera to assignCamaras
    }
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
        initSearchBar()
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
        if searchController.active && searchController.searchBar.text != "" {
            return filterCamera.count
        }
        return (cameras.count)
    }
    
    func saveAssignedCameras() {
        print("Save assigned cameras")
        
        let statusCode = AppUtility.assignCameraToUser(assignedCameras!, toUser: selectedUser)
        print("Code: \(statusCode)")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "cameraTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CameraTableViewCell
        let camera : CameraObject
        if searchController.active && searchController.searchBar.text != "" {
            camera = filterCamera[indexPath.row]
        } else {
            camera = cameras[indexPath.row]
        }
        
        cell.cameraDescription.text = camera.name
        cell.switchOn.on = AppUtility.findCamera(assignedCameras!, whichCamera: camera)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        NSLog("did select and the text is \(cell?.textLabel?.text)")
    }
    
    
    @IBAction func prepareForUnwindAssignedCameraView(sender: UIStoryboardSegue) {
        if let configDateController = sender.sourceViewController as? ConfigDateTableViewController {
            print("Unwind row: \(selectedIndexPath?.row)")
            cameras[(selectedIndexPath?.row)!] = configDateController.selectedCamera
        }
        
        delegate.setupNavigation((self.navigationController?.navigationBar)!, titleName: "List Camera")
    }


    
    func initSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.tintColor = UIColor.blackColor()
    }
    
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
    
    func filterContentForSearchText(searchText: String) {
        filterCamera = cameras.filter({( camera : CameraObject) -> Bool in
            return camera.name.lowercaseString.containsString(searchText.lowercaseString)
        })
        tableView.reloadData()
    }

}

extension AssignedCameraTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
}

extension AssignedCameraTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

