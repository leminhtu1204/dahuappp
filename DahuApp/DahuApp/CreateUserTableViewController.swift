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
    
    @IBOutlet weak var btnSaveData: UIBarButtonItem!
    var user: UserProfile?
    
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func btnCancel(sender: AnyObject) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if btnSaveData === sender {
            insertUser()
        }
    }

    func insertUser(){
    
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        let entityDescription =
        NSEntityDescription.entityForName("UserProfile",
            inManagedObjectContext: context)
        
        user = UserProfile(entity: entityDescription!,
            insertIntoManagedObjectContext: context)
        
        user!.fullname = txtFullName.text
        user!.password = txtPassword.text
        user!.email = txtEmail.text
        user!.createdDate = NSDate()
        
        do{
             try context.save()
            
        } catch {
            print("error")
        }
        
    }

}
