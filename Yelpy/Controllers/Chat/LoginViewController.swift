//
//  LoginViewController.swift
//  Yelpy
//
//  Created by Duy Le on 3/5/21.
//  Copyright © 2021 memo. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*------ SIGN UP AND LOG IN FUNCTIONALITY  ------*/
    @IBAction func onSignUp(_ sender: Any) {
        // Sign up user
            // Check text field inputs
            if !usernameAndPasswordNotEmpty(){
              // initialize a user object
              let newUser = PFUser()
              // set user properties
              newUser.username = usernameTextField.text
              newUser.password = passwordTextField.text
              // call sign up function on the object
              newUser.signUpInBackground { (sucess: Bool, error: Error?) in
                if let error = error {
                  print(error.localizedDescription)
                  self.displaySignupError(error: error)
                } else {
                  print("User \(newUser.username!) Registered successfullly")
                  NotificationCenter.default.post(name: NSNotification.Name("login"), object: nil)
                }
              }
            } else {
        //      displayEmptyTextError()
              print("Empty text error")
            }
        
    }
    
    
    @IBAction func onLogin(_ sender: Any) {
        // Login user
        if !usernameAndPasswordNotEmpty(){
          let username = usernameTextField.text ?? ""
          let password = passwordTextField.text ?? ""
          PFUser.logInWithUsername(inBackground: username, password: password) {
            (user: PFUser?, error: Error?) in
            if let error = error {
              print("user log in failed: \(error.localizedDescription)")
              self.displayLoginError(error: error)
            } else {
              print("User \(username) logged in successfully")
              NotificationCenter.default.post(name: NSNotification.Name("login"), object: nil)
            }
          }
        } else {
    //      displayEmptyTextError()
        }

        
    }
    

    /*------ Handle text field inputs  ------*/
    func usernameAndPasswordNotEmpty() -> Bool {
        return usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty
    }
    
    /*------ Alert Controllers ------*/
    // Text fields are empty alert controller
    func displayError() {
        let title = "Error"
        let message = "Username and password field cannot be empty"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    // Login error alert controller
    func displayLoginError(error: Error) {
        let title = "Login Error"
        let message = "Oops! Something went wrong while logging in: \(error.localizedDescription)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    
    // Sign up error alert controller
    func displaySignupError(error: Error) {
        let title = "Sign up error"
        let message = "Oops! Something went wrong while signing up: \(error.localizedDescription)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }

}
