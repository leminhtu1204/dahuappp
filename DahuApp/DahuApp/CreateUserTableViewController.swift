//
//  CreateUserTableViewController.swift
//  DahuApp
//
//  Created by Le Minh Tu on 2/21/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//

import UIKit
import CoreData

class CreateUserTableViewController: UITableViewController {
    
    @IBAction func btnCancel(sender: AnyObject) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }

    }
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBAction func btnSave(sender: AnyObject) {
        
        insertUser()
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return 2
    }
    
    func insertUser(){
    
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        var user = NSEntityDescription.insertNewObjectForEntityForName("UserProfile", inManagedObjectContext: context)
        
        user.setValue(txtFullName.text, forKey: "fullname")
        user.setValue("password", forKey: "password")
        user.setValue(txtEmail.text, forKey: "email")
        user.setValue(NSDate(), forKey: "createdDate")
        
        do{
             try context.save()
            
        } catch {
            print("error")
        }
        
    }

}
