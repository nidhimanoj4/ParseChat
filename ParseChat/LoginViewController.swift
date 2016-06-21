//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Simon Posada Fishman on 6/21/16.
//  Copyright © 2016 Simon Posada Fishman. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alertForError(error: NSError) -> Void {
        let message = error.localizedDescription
        let title = "Error: " + String(error.code)
        let alertController = UIAlertController(title: title, message: message.capitalizedString, preferredStyle: .Alert)

        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        presentViewController(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        let email = emailField.text
        let password = passwordField.text
        PFUser.logInWithUsernameInBackground(email!, password: password!) { (user: PFUser?,error: NSError?) in
            if user != nil {
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                //throw an error for 101
                self.alertForError(error!)                
            }
            
        }
    
    }
    @IBAction func onSignUp(sender: AnyObject) {
        //initialize the user object
        let user = PFUser()
        
        user.email = emailField.text
        user.username = emailField.text
        user.password = passwordField.text
        
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) in
            if success {
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                //handle error 200 and 125
                self.alertForError(error!)
            }
        }
    
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
