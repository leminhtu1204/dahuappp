//
//  LoginViewController.swift
//  DahuApp
//
//  Created by Le Minh Tu on 1/24/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var btnPassword: UITextField!
    
    @IBAction func btnSignIn(sender: AnyObject) {
        if (txtUserName.text == "admin"){
            self.performSegueWithIdentifier("adminSegue", sender: sender)
        }else{
            self.performSegueWithIdentifier("userSegue", sender: sender)
        }
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
