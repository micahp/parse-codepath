//
//  ChatViewController.swift
//  parse-codepath
//
//  Created by Micah Peoples on 2/23/17.
//  Copyright © 2017 micah. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    var messages: [[String:String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sendButton.layer.cornerRadius = 3
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.refresh), userInfo: nil, repeats: true)
    }
    
    func refresh() {
        var query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (objects, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                if let objects = objects {
                    for object in objects {
                        let text = object["text"] as? String ?? ""
                        let username = ""
                        if text != "" {
                            self.messages.append(["text":text, "username":username])
                        }
                    }
                }
            }
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSendMessageButtonTapped(_ sender: Any) {
        let messageText = messageTextField.text
        let message = PFObject(className: "Message")
        message["text"] = messageText
        message["user"] = PFUser.current()
        message.saveInBackground { (bool, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Message was saved")
            }
        }
        
    }
    
    @IBAction func onLogOutButtonTapped(_ sender: Any) {
        
        PFUser.logOutInBackground { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Successfully logged out user.")
            }
        }
        
        dismiss(animated: true) {
            print("dismissed chat view controller modal")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageCell
        cell.messageLabel.text = messages[indexPath.row]["text"]
        //cell.authorLabel.text = messages[indexPath.row]["username"]
        //print (cell.authorLabel.text)
        return cell
    }
    
}
