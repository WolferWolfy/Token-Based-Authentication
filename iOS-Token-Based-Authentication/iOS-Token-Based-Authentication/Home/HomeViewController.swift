//
//  HomeViewController.swift
//  iOS-Token-Based-Authentication
//
//  Created by Farkas Marton Imre on 09/06/15.
//  Copyright (c) 2015 Farkas Marton Imre. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {


    @IBAction func loginButtonPressed(sender: AnyObject) {
        self.tabBarController?.selectedIndex = 1

    }
    
    @IBAction func signUpButtonPressed(sender: AnyObject) {
        self.tabBarController?.selectedIndex = 2

    }

}
