//
//  ViewController.swift
//  iOS-Token-Based-Authentication
//
//  Created by Farkas Marton Imre on 08/06/15.
//  Copyright (c) 2015 Farkas Marton Imre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var placeholderMenuView: MenuView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        var nibView = NSBundle.mainBundle().loadNibNamed("MenuView", owner: self, options: nil)[0] as! UIView
        nibView.frame = placeholderMenuView.frame
        self.view.addSubview(nibView)
        
    }

}

