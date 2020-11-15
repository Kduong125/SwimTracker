//
//  LoginViewController.swift
//  SwimTracker
//
//  Created by Kenneth Duong on 10/18/20.
//  Copyright © 2020 Kenneth Duong. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
    }
    
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    self.errorLabel.text = "Invalid Credentials, try again."
                } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                }
            }
        }
    }
    
}
