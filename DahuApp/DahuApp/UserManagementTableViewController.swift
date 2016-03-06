//
//  UserManagementTableViewController.swift
//  DahuApp
//
//  Created by Le Minh Tu on 2/21/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//

import UIKit

class UserManagementTableViewController: UITableViewController {
    
    var loginUser = UserObject()
    var selectedUser = UserObject()
    var selectedRow = 0 as Int
    var selectedIndexPath: NSIndexPath?
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let searchController = UISearchController(searchResultsController: nil)
    var filterUser = [UserObject]()
    
    func deleteUser(index: Int){
        let selectedUser = loginUser.userList![index]
        
        let isSuccessfully = AppUtility.deleleUser(selectedUser.id!) as Bool
        print("Is user deleted? - \(isSuccessfully)")
        loginUser.userList?.removeAtIndex(index)
    }
    
    func initSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["Name", "Email"]
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = UIColor.blackColor()
    }
    
    func initNavigate(){
        delegate.setupNavigation((self.navigationController?.navigationBar)!, titleName: "User Management")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBarHidden = false
        initNavigate()
        initSearchBar()
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
            return filterUser.count
        }
        return (loginUser.userList?.count)!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UserTableViewCell
        let user : UserObject
        
        if searchController.active && searchController.searchBar.text != "" {
            user = filterUser[indexPath.row]
        } else {
            user = loginUser.userList![indexPath.row]
        }
        
        cell.lblFullName.text = user.fullName
        cell.lblEmail.text = user.email
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .Normal, title: "Edit") { action, index in
            self.selectedUser = self.loginUser.userList![indexPath.row]
            self.selectedRow = indexPath.row
            self.selectedIndexPath = indexPath
            self.performSegueWithIdentifier("editUserSegue", sender: self)
        }
        edit.backgroundColor = UIColor.blueColor()
        
        let delete = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in
            self.deleteUser(indexPath.row)
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        delete.backgroundColor = UIColor.redColor()

        return [edit, delete]
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editUserSegue" {
            let editUserTableViewController = segue.destinationViewController as! EditUserTableViewController
            editUserTableViewController.editingUser = self.selectedUser
        }
        
        if segue.identifier == "assignCameras" {
            selectedUser = loginUser.userList![(tableView.indexPathForSelectedRow?.row)!]
            print("Select user for assigning camera: \(selectedUser.email)")
            let assignedCameraTableViewController = segue.destinationViewController as! AssignedCameraTableViewController
            assignedCameraTableViewController.selectedUser = selectedUser
            assignedCameraTableViewController.cameras = loginUser.cameras!
            assignedCameraTableViewController.assignedCameras = AppUtility.getAssignedCameras(selectedUser)
        }
    }
    
    @IBAction func prepareForUnwind(sender: UIStoryboardSegue) {
        initNavigate()
        if let createViewController = sender.sourceViewController as? CreateUserTableViewController {
            if let newUser = createViewController.newUser as? UserObject {
                let newIndexPath = NSIndexPath(forRow: loginUser.userList!.count, inSection: 0)
                loginUser.userList?.append(newUser)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
        
        if let editUserController = sender.sourceViewController as? EditUserTableViewController {
            if let editingUser = editUserController.editingUser as? UserObject {
                loginUser.userList![selectedRow] = editingUser
                tableView.reloadRowsAtIndexPaths([selectedIndexPath!], withRowAnimation: .None)
            }
        }
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "Name") {
        filterUser = loginUser.userList!.filter({( user : UserObject) -> Bool in
            if(scope == "Email"){
                return user.email.lowercaseString.containsString(searchText.lowercaseString)
            }
            return user.fullName.lowercaseString.containsString(searchText.lowercaseString)
        })
        tableView.reloadData()
    }

}


extension UserManagementTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension UserManagementTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

