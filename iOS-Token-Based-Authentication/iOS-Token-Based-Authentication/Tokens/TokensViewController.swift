//
//  TokensViewController.swift
//  iOS-Token-Based-Authentication
//
//  Created by Farkas Marton Imre on 10/06/15.
//  Copyright (c) 2015 Farkas Marton Imre. All rights reserved.
//

import UIKit

class TokensViewController: UIViewController, AuthTokenRefreshDelegate {
    
    let authManager = AuthManager()
    let userManager = UserDataManager.sharedInstance
    
    
    @IBOutlet weak var refreshTokenView: UIView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var refreshTokenValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadingIndicator.stopAnimating()
        loadingIndicator.hidden = true
        
        refreshTokenView.hidden = true
    }

    
    
    @IBAction func RefreshTokenPressed(sender: AnyObject) {
        authManager.authTokenRefreshDelegate = self
        loadingIndicator.startAnimating()
        loadingIndicator.hidden = false
        
        if let refreshToken = userManager.getUserData().refresh_token {
            authManager.tokenRefresh(refreshToken)
        }
    }

    @IBAction func ViewOrdersPressed(sender: AnyObject) {
        tabBarController?.selectedIndex = 4
    }
    
    
    func tokenRefreshFinished(response: String?) {
        loadingIndicator.stopAnimating()
        loadingIndicator.hidden = true
        if let responseString = response{
            var result = StringParser.stringToDictionary(response!)
            
            userManager.saveUserData(result["client_id"], accessToken: result["access_token"], refreshToken: result["refresh_token"], userName: result["userName"])
            
            refreshTokenValue.text = result["access_token"]
            
            refreshTokenView.hidden = false
            
        }
    }
}
