//
//  LoginViewController.swift
//  DahuApp
//
//  Created by Le Minh Tu on 1/24/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class LoginViewController: UIViewController {
    var loginUser = UserObject()
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var btnPassword: UITextField!
    
    @IBAction func btnSignIn(sender: AnyObject) {
     //   let userObject = AppUtility.loginUser(txtUserName.text!, pass: btnPassword.text!) as UserObject
        loginUser = AppUtility.loginUser(txtUserName.text!, pass: btnPassword.text!) as UserObject
        
        if (loginUser.email == "") {
            raiseAlert()
        } else {
            if (loginUser.isAdmin) {
                self.performSegueWithIdentifier("adminSegue", sender: sender)
            } else {
                self.performSegueWithIdentifier("userSegue", sender: sender)

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
        self.navigationController!.navigationBarHidden = true
        // Do any additional setup after loading the view.
     
//        let camera1 = CameraObject(id: 1, link: "trung.link", name: "Camera 1", fromDate: nil, toDate: nil)
//        let camera2 = CameraObject(id: 2, link: "trung.link", name: "Camera 1", fromDate: NSDate(), toDate: NSDate())
//        let camera3 = CameraObject(id: 3, link: "trung.link", name: "Camera 1", fromDate: nil, toDate: nil)
//        
//        let cameraList = [camera1, camera2, camera3]
//        let user = UserObject(id: 21, fullName: "Full Name", email: "email", isAdmin: true, password: "rfer")
//        
//        AppUtility.assignCameraToUser(cameraList, toUser: user)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func prepareForUnwind(sender: UIStoryboardSegue) {
        self.navigationController!.navigationBarHidden = true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "adminSegue" {
            let userManagementTableViewController = segue.destinationViewController as! UserManagementTableViewController
            userManagementTableViewController.loginUser = loginUser
        }else{
            let cameraCollectionTableViewController = segue.destinationViewController as! CameraCollectionTableViewController
            cameraCollectionTableViewController.loginUser = loginUser
        }
    }
    

}
