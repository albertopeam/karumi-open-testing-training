//
//  ViewController.swift
//  KataLogInLogOut
//
//  Created by Alberto on 20/9/18.
//  Copyright © 2018 com.github.albertopeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    private let kataApp = KataApp()

    @IBAction func login(_ sender: UIButton) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        if kataApp.logIn(username: username, password: password) {
            print("logged")
        }else{
            print("not logged")
        }
    }
}

