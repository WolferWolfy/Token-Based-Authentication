//
//  AuthManager.swift
//  iOS-Token-Based-Authentication
//
//  Created by Farkas Marton Imre on 11/06/15.
//  Copyright (c) 2015 Farkas Marton Imre. All rights reserved.
//

import Foundation

protocol AuthRegistrationDelegate : class {
    func registrationFinished(response : String?)
}

protocol AuthLoginDelegate : class {
    func loginFinished(response : String?)
}

protocol AuthOrdersDelegate : class {
    func ordersFinished(response : String?)
}

protocol AuthTokenRefreshDelegate : class {
    func tokenRefreshFinished(response: String?)
}

class AuthManager {
    
    var serviceBase = "http://ngauthenticationapi.azurewebsites.net/"
    
    weak var authRegistrationDelegate : protocol<AuthRegistrationDelegate>?
    weak var authLoginDelegate : protocol<AuthLoginDelegate>?
    weak var authOrdersDelegate: protocol<AuthOrdersDelegate>?
    weak var authTokenRefreshDelegate: protocol<AuthTokenRefreshDelegate>?

    let userManager = UserDataManager.sharedInstance
    
    func registerUser(userName : String, password: String) {
        
        var httpPostUri = serviceBase + "api/account/register"
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: httpPostUri)!)
        request.HTTPMethod = "POST"
        let postString = "userName=\(userName)&password=\(password)&confirmPassword=\(password)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
         //       println("error=\(error)")
                return
            }
            
         //   println("response = \(response)")
            
            
          //  var responseJson = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
         //   println("responseString = \(responseString)")
            
          //  let responseString2 = responseJson["modelState"] as! NSString
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.authRegistrationDelegate?.registrationFinished(responseString)
                
            })
            
        }
        task.resume()
    
    }
   
    func login(userName : String, password: String, userRefreshToken: Bool) {
        
        var httpPostUri = serviceBase + "token"
        
        let request = NSMutableURLRequest(URL: NSURL(string: httpPostUri)!)
        request.HTTPMethod = "POST"
        var postString = "grant_type=password&username=" + userName + "&password=" + password
        if ( userRefreshToken) {
            postString = postString.stringByAppendingString("&client_id=ngAuthApp")
        }
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                println("error=\(error)")
                return
            }
            
           // println("response = \(response)")
            
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
           // println("responseString = \(responseString)")
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.authLoginDelegate?.loginFinished(responseString)
            })
           
        }
        
        task.resume()
   /*     var deferred = $q.defer();
        
        $http.post(serviceBase + 'token', data, { headers: { 'Content-Type': 'application/x-www-form-urlencoded' } }).success(function (response) {
            
            localStorageService.set('authorizationData', { token: response.access_token, userName: loginData.userName });
            
            _authentication.isAuth = true;
            _authentication.userName = loginData.userName;
            
            deferred.resolve(response);
            
            }).error(function (err, status) {
                _logOut();
                deferred.reject(err);
                });
        
        return deferred.promise;*/
        
    }

    func orders() {
        var httpGetUri = serviceBase + "api/orders"
        
        userManager.loadUserData()
        
        if let tokenValue = userManager.getUserData().access_token {
            
            var bearerToken = "Bearer " + tokenValue
        
            let request = NSMutableURLRequest(URL: NSURL(string: httpGetUri)!)
            request.HTTPMethod = "GET"
            request.setValue("ngAuthApp", forHTTPHeaderField: "client_id")
            request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
            
                if error != nil {
                    println("error=\(error)")
                    return
                }
            
              //  println("response = \(response)")
            
                let responseString = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
                //println("responseString = \(responseString)")
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.authOrdersDelegate?.ordersFinished(responseString)
                })
            
            }
        task.resume()
        }
    }
    
    func tokenRefresh(refreshToken: String) {
        var httpPostUri = serviceBase + "token"
        
        let request = NSMutableURLRequest(URL: NSURL(string: httpPostUri)!)
        request.HTTPMethod = "POST"
        var postString = "grant_type=refresh_token&refresh_token=" + refreshToken + "&client_id=" + "ngAuthApp"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                println("error=\(error)")
                return
            }
            
            // println("response = \(response)")
            
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
            // println("responseString = \(responseString)")
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.authTokenRefreshDelegate?.tokenRefreshFinished(responseString)
            })
            
        }
        
        task.resume()
    }
}