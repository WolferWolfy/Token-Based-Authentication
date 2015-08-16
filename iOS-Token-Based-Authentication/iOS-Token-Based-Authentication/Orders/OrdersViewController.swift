//
//  ViewController.swift
//  iOS-Token-Based-Authentication
//
//  Created by Farkas Marton Imre on 10/06/15.
//  Copyright (c) 2015 Farkas Marton Imre. All rights reserved.
//

import UIKit

class OrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AuthOrdersDelegate {
    
    let userManager = UserDataManager.sharedInstance
    let authManager = AuthManager()
    
    var orders = [Order]()
    
    @IBOutlet weak var ordersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        authManager.authOrdersDelegate = self
        authManager.orders()
    }

    override func viewWillAppear(animated: Bool) {
        startSetup()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        startSetup()
    }
    

    func startSetup() {
        if !userManager.isUserLoggedIn() {
            self.tabBarController?.selectedIndex = 1
        }
        else {
            ordersTableView.hidden = false
        }
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orders.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("OrderItemTableViewCell") as! OrderItemTableViewCell
        
        cell.setupCell(orders[indexPath.row])
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("OrderHeaderTableViewCell") as! UITableViewCell
            
            var sectionHeaderView = cell.contentView
            return sectionHeaderView
        }
        
        return nil
    }
    
    
    func ordersFinished(response: String?) {
        
        orders = StringParser.stringToOrderArray(response!)
        self.ordersTableView.reloadData()
        //println(response)
    }


}
