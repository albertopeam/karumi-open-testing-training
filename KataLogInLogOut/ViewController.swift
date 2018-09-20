//
//  ViewController.swift
//  KataLogInLogOut
//
//  Created by Alberto on 20/9/18.
//  Copyright © 2018 com.github.albertopeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    private let kataApp = KataApp(clock: Clock())

    @IBAction func login(_ sender: UIButton) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        if kataApp.logIn(username: username, password: password) {
            usernameTextField.isHidden = true
            passwordTextField.isHidden = true
            logoutButton.isHidden = false
            loginButton.isHidden = true
        }else{
            print("not logged")
        }
    }
    
    @IBAction func logout(_ sender: UIButton) {
        if kataApp.logOut() {
            usernameTextField.text = ""
            passwordTextField.text = ""
            usernameTextField.isHidden = false
            passwordTextField.isHidden = false
            logoutButton.isHidden = true
            loginButton.isHidden = false
        }else {
            
        }
    }
}

