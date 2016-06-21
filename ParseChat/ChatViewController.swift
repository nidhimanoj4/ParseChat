//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Simon Posada Fishman on 6/21/16.
//  Copyright © 2016 Simon Posada Fishman. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageField: UITextField!
    
    var chatMessages: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
         NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSend(sender: AnyObject) {
        
        let message = PFObject(className: "Message_fbuJuly2016")
        
        message["text"] = messageField.text!
        message["user"] = PFUser.currentUser()
        
        message.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
            if success {
                print(self.messageField.text!)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func onTimer() {
        // Add code to be run periodically
       
        
        let query = PFQuery(className: "Message_fbuJuly2016")
        query.orderByDescending("createdAt")
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("downloaded chat")
                self.chatMessages = objects!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as! MessageCell
        cell.messageLabel.text = chatMessages[indexPath.row].valueForKey("text") as? String
        let user = chatMessages[indexPath.row].valueForKey("user") as? PFUser

        cell.userLabel.text = user?.email ?? user?.username ?? ""
        
        return cell
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
