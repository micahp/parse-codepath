//
//  LoginViewController.swift
//  parse-codepath
//
//  Created by Micah Peoples on 2/23/17.
//  Copyright © 2017 micah. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpButton.layer.cornerRadius = 3
        loginButton.layer.cornerRadius = 3
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validate() {
        
        let alertController = UIAlertController(title: "Missing Fields", message: "Username and password are required.", preferredStyle: .alert)
        
//        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
//            // handle cancel response here. Doing nothing will dismiss the view.
//        }
//        
//        // add the cancel action to the alertController
//        alertController.addAction(cancelAction)
        
        // create an OK action
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        
        // add the OK action to the alert controller
        alertController.addAction(okAction)
        
        
        if emailTextField.text == "" || passwordTextField.text == "" {
           
           present(alertController, animated: true, completion: {
                // optional code for what happens after the alert controller has finished presenting
           })
            
        }
        
    }
    
    func signIn(username: String, password: String) {
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if let error = error {
                print ("error: \(error.localizedDescription)")
            } else {
                print ("Signed in user \(username)")
                print (user)
                
                self.performSegue(withIdentifier: "showChatView", sender: nil)
                //self.storyboard?.instantiateViewController(withIdentifier: "chatViewController")
                
                
                
            }
        }
    }
    
    
    @IBAction func onTapSignUpButton(_ sender: Any) {
        validate()
        var user = PFUser()
        let username = emailTextField.text!
        let password = passwordTextField.text!
        
        user.username = username
        user.password = password
        print("after validate")

        // Email optional
        // Other fields can be set just like with PFObject
        //user["phone"] = "415-392-0202"
        
        user.signUpInBackground { (bool, error) in
            if let error = error {
                // Show the errorString somewhere and let the user try again.
                print ("error: \(error.localizedDescription)")
            } else {
                // User is signed up. Let the use app now.
                print ("Signed up user \(username). Now signing in.")
                self.signIn(username: username, password: password)
                
            }
        }
    }

    @IBAction func onTapLoginButton(_ sender: Any) {
        validate()
        
        let username = emailTextField.text!
        let password = passwordTextField.text!
        
        signIn(username: username, password: password)
        
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
