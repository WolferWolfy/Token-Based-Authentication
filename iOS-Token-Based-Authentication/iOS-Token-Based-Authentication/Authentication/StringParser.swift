//
//  StringParser.swift
//  iOS-Token-Based-Authentication
//
//  Created by Farkas Marton Imre on 11/06/15.
//  Copyright (c) 2015 Farkas Marton Imre. All rights reserved.
//

import Foundation

class StringParser {
    
    class func stringToDictionary(stringData : String) -> Dictionary<String, String> {

        var data = stringData.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
        var localError: NSError?
        var json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &localError)

        var returnDictionary = Dictionary<String, String>()
        if let dict = json as? [String : AnyObject] {
            //println(dict)
            
            for (key,value) in dict {
                returnDictionary[key] = dict[key] as? String
            }
        }
        
        return returnDictionary
    }
    
    class func stringToOrderArray(stringData : String) -> [Order] {
        
        var data = stringData.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
        var localError: NSError?
        var json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &localError)
        
        var returnOrderArray = [Order]()
        
            if let dictArray = json as? [[String : AnyObject]]  {
                for arrayElement in dictArray {
                    var isShipped = arrayElement["isShipped"] as! Bool
                    var shipperCity = arrayElement["shipperCity"] as! String
                    var orderID = arrayElement["orderID"] as! Int
                    var customerName = arrayElement["customerName"] as! String
                    returnOrderArray.append(Order(orderId: orderID, customerName: customerName, shipperCity: shipperCity, isShipped: isShipped))
                }
            }
        

        return returnOrderArray
    }
    
    



}