//
//  OrderItemTableViewCell.swift
//  iOS-Token-Based-Authentication
//
//  Created by Farkas Marton Imre on 10/06/15.
//  Copyright (c) 2015 Farkas Marton Imre. All rights reserved.
//

import UIKit

class OrderItemTableViewCell: UITableViewCell {

    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var isShippedSwitch: UISwitch!
    

    func setupCell(order: Order) {
        orderIdLabel.text = "\(order.orderId)"
        customerLabel.text = order.customerName
        cityLabel.text = order.shipperCity
        isShippedSwitch.on = order.isShipped
    }

}
