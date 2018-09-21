//
//  ViewController.swift
//  KataLogInLogOut
//
//  Created by Alberto on 20/9/18.
//  Copyright © 2018 com.github.albertopeam. All rights reserved.
//

import UIKit

class AccessViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    private let kataApp = AccessUseCase(clock: Clock())
    private let presenter = AccessPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
    }

    @IBAction func login(_ sender: UIButton) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        presenter.login(username: username, password: password)
    }
    
    @IBAction func logout(_ sender: UIButton) {
        presenter.logOut()
    }
    
}

extension AccessViewController: AccessView {
    
    func showLogInForm() {
        usernameTextField.text = ""
        passwordTextField.text = ""
        usernameTextField.isHidden = false
        passwordTextField.isHidden = false
        loginButton.isHidden = false
    }
    
    func hideLogInForm() {
        usernameTextField.isHidden = true
        passwordTextField.isHidden = true
        loginButton.isHidden = true
    }
    
    func showLogOutForm() {
        usernameTextField.isHidden = true
        passwordTextField.isHidden = true
        logoutButton.isHidden = false
        loginButton.isHidden = true
    }
    
    func hideLogOutForm() {
        logoutButton.isHidden = true
    }
    
    func showError(error: String) {
        print("error: \(error)")
    }
    
    
}

