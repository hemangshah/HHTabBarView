//
//  ViewController.swift
//  HHTabBarView
//
//  Created by Hemang Shah on 7/17/17.
//  Copyright © 2017 Hemang Shah. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var apd = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Refresh"
    }
    
    @IBAction func actionShowHideTabBar(_ sender: UISwitch) {
        
        if !apd.hhTabBarView.isHidden {
            apd.hideTabBar()
        } else {
            apd.showTabBar()
        }
        
    }
    
    @IBAction func actionShowHideNavigationBar(_ sender: UISwitch) {
        self.navigationController?.isNavigationBarHidden = !sender.isOn
    }
}
