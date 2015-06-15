//
//  SignUpViewController.swift
//  iOS-Token-Based-Authentication
//
//  Created by Farkas Marton Imre on 10/06/15.
//  Copyright (c) 2015 Farkas Marton Imre. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, AuthRegistrationDelegate {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    let authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        authManager.authRegistrationDelegate = self
        loadingIndicator.startAnimating()
        loadingIndicator.hidden = false
        
        if passwordField.text != confirmPasswordField.text {
            setErrorLabelText("Passwords do not match")
        }
        authManager.registerUser(userNameField.text, password: passwordField.text)
    }
    
    func registrationFinished(response: String?) {
        loadingIndicator.stopAnimating()
        loadingIndicator.hidden = true
        if let resultString = response {

            if  count(resultString) > 0 {
                setErrorLabelText(resultString)
                return
            }
        }
            setErrorLabelText("User registered. You will be navigated to login.")
            errorLabel.textColor = UIColor.greenColor()
            var timer = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: Selector("navigateToLogin"), userInfo: nil, repeats: false)

    }
    
    func setErrorLabelText(text: String) {
        errorLabel.text = text
        errorLabel.hidden = false;
    }
    
    func navigateToLogin() {
        clearFields()
        self.tabBarController?.selectedIndex = 1
    }
    
    func clearFields() {
        userNameField.text = nil
        passwordField.text = nil
        confirmPasswordField.text = nil
        errorLabel.text = nil
        errorLabel.hidden = true
    }
}
