//
//  MenuViewController.swift
//  iOS-Token-Based-Authentication
//
//  Created by Farkas Marton Imre on 08/06/15.
//  Copyright (c) 2015 Farkas Marton Imre. All rights reserved.
//

import UIKit

class MenuTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skyBlueColor = UIColor(red: 0.0, green: 141/255, blue: 189/255, alpha: 1.0)
        UITabBarItem.appearance().setTitleTextAttributes(  [NSForegroundColorAttributeName : skyBlueColor], forState: UIControlState.Selected)
        UITabBarItem.appearance().setTitleTextAttributes(  [NSForegroundColorAttributeName : UIColor.blackColor()], forState: UIControlState.Normal)
        
        UITabBar.appearance().tintColor = skyBlueColor
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
