//
//  LogInOutViewController.swift
//  iOS-Token-Based-Authentication
//
//  Created by Farkas Marton Imre on 10/06/15.
//  Copyright (c) 2015 Farkas Marton Imre. All rights reserved.
//

import UIKit

class LogInOutViewController: UIViewController, AuthLoginDelegate {


    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loggedInUserNameField: UILabel!
    @IBOutlet weak var refreshTokenSwitch: UISwitch!
    
    @IBOutlet weak var logInOutTabBarItem: UITabBarItem!
    
    let authManager = AuthManager()
    let userManager = UserDataManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(animated: Bool) {
        loadingIndicator.hidden = true
        loginView.hidden = userManager.isUserLoggedIn()
        logInOutTabBarItem.image = UIImage(named: userManager.isUserLoggedIn() ? "Exit-50" : "Enter-50")
    }

    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        authManager.authLoginDelegate = self
        loadingIndicator.startAnimating()
        loadingIndicator.hidden = false
        
        authManager.login(userNameField.text, password: passwordField.text, userRefreshToken: refreshTokenSwitch.on)
    }
    
    func loginFinished(response: String?) {
        println("loginFinished")
        
        loadingIndicator.stopAnimating()
        loadingIndicator.hidden = true
        
        var result = StringParser.stringToDictionary(response!)
        
        userManager.saveUserData(result["client_id"], accessToken: result["access_token"], refreshToken: result["refresh_token"], userName: result["userName"])
        
        loginView.hidden = userManager.isUserLoggedIn()
        loggedInUserNameField.text = userManager.getUserData().userName
        
        logInOutTabBarItem.title = "Logout"
        logInOutTabBarItem.image = UIImage(named: "Exit-50")
        
    }
    
    
    @IBAction func logoutButtonPressed(sender: AnyObject) {
        
        userManager.deleteUserData()
        loginView.hidden = userManager.isUserLoggedIn()
        loggedInUserNameField.text = "you are not loged in"
        
        logInOutTabBarItem.title = "Login"
        logInOutTabBarItem.image = UIImage(named: "Enter-50")
        
        
    }
    

}
