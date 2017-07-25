//
//  ViewController.swift
//  HHTabBarView
//
//  Created by Hemang Shah on 7/17/17.
//  Copyright © 2017 Hemang Shah. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet var btnShowHideTabBar: UIButton!
    var apd = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Refresh"
    }
    
    @IBAction func actionShowHideTabBar(_ sender: UIButton) {
        if apd.tabbarController.tabBar.isHidden {
            apd.showTabBar()
            btnShowHideTabBar.setTitle("Hide TabBar", for: .normal)
        } else {
            apd.hideTabBar()
            btnShowHideTabBar.setTitle("Show TabBar", for: .normal)
        }
    }
}
