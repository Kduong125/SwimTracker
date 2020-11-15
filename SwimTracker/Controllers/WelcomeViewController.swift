//
//  ViewController.swift
//  SwimTracker
//
//  Created by Kenneth Duong on 10/16/20.
//  Copyright © 2020 Kenneth Duong. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
       guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")}
        navBar.backgroundColor = UIColor(named: BrandColors.lightBlue)
//        showApp()
    }

    }

