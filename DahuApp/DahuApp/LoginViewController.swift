//
//  LoginViewController.swift
//  DahuApp
//
//  Created by Le Minh Tu on 1/24/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var btnPassword: UITextField!
    
    @IBAction func btnSignIn(sender: AnyObject) {
        if (txtUserName.text == "admin" && btnPassword.text == "admin"){
            self.performSegueWithIdentifier("adminSegue", sender: sender)
        } else {
            if (checkUser()) {
                self.performSegueWithIdentifier("userSegue", sender: sender)
            } else {
                raiseAlert()
            }
        }
    }
    
    func raiseAlert() {
        // test alert
        let alertController = UIAlertController(title: "Wrong User/Password", message: "Please try again!", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func checkUser() -> Bool{
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "UserProfile")
        
        //3
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            for user in results {
                print(user.valueForKey("email"))
                print(user.valueForKey("password"))
                
                if  user.valueForKey("email") as? String == txtUserName.text && user.valueForKey("password") as? String == btnPassword.text {
                    // To do sthing
                    return true
                }            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
