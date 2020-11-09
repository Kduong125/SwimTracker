//
//  RegisterViewController.swift
//  SwimTracker
//
//  Created by Kenneth Duong on 10/18/20.
//  Copyright © 2020 Kenneth Duong. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
    }
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    if password.count < 6 {
                        self.errorLabel.text = "Password must be 6 characters or more"
                    } else {
                    self.errorLabel.text = "Sign up failed, please enter a valid email."
                    }
                } else {
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
    }
    
    
    
    
}
