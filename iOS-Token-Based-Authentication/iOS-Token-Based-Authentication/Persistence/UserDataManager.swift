//
//  UserData.swift
//  iOS-Token-Based-Authentication
//
//  Created by Farkas Marton Imre on 12/06/15.
//  Copyright (c) 2015 Farkas Marton Imre. All rights reserved.
//

import Foundation

class UserDataManager {
    
    static let sharedInstance = UserDataManager()

    private let userKey = "UserDataKey"
 
    private var userData = UserData()
    
    func saveUserData(client: String?, accessToken: String?, refreshToken: String?, userName: String?) {
        
        userData.client_id = client
        userData.access_token = accessToken
        userData.refresh_token = refreshToken
        userData.userName = userName
        
        saveUserData(userData)
    }

    func saveUserData(userData : UserData) {
        self.userData = userData
        self.userData.save()
    }
    
    func loadUserData() -> UserData {
        userData.load()
        return userData
    }
    
    func getUserData() -> UserData {
        return userData
    }
    
    func deleteUserData() {
        userData.delete()
        userData = UserData()
    }
    
    
    //TODO: check for token validity
    func isUserLoggedIn() -> Bool {
        return userData.userName != nil
    }
}

class UserData  {
    var client_id : String?
    var access_token: String?
    var refresh_token: String?
    var userName: String?
    
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    
    func save() {
        userDefaults.setObject(client_id, forKey: "clientId")
        userDefaults.setObject(access_token, forKey: "accessToken")
        userDefaults.setObject(refresh_token, forKey: "refreshToken")
        userDefaults.setObject(userName, forKey: "userName")
        userDefaults.synchronize()
    }
    
    func load() {
        client_id = userDefaults.objectForKey("clientId") as? String
        access_token = userDefaults.objectForKey("accessToken") as? String
        refresh_token = userDefaults.objectForKey("refreshToken") as? String
        userName = userDefaults.objectForKey("userName") as? String
    }
    
    func delete() {
        userDefaults.removeObjectForKey("clientId")
        userDefaults.removeObjectForKey("accessToken")
        userDefaults.removeObjectForKey("refreshToken")
        userDefaults.removeObjectForKey("userName")
        userDefaults.synchronize()
    }
}

class Order {
    var orderId : Int
    var customerName : String
    var shipperCity : String
    var isShipped : Bool
    
    init(orderId: Int, customerName: String, shipperCity: String, isShipped: Bool) {
        self.orderId = orderId
        self.customerName = customerName
        self.shipperCity = shipperCity
        self.isShipped = isShipped
    }
}