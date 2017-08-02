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
    
    @IBAction func actionShowHideBadge(_ sender: UISwitch) {
        if sender.isOn {
            apd.hhTabBarView.updateBadge(forTabIndex: 0, withValue: Int(arc4random()%30) + 1)
            apd.hhTabBarView.updateBadge(forTabIndex: 2, withValue: Int(arc4random()%30) + 1)
            apd.hhTabBarView.updateBadge(forTabIndex: 3, withValue: Int(arc4random()%30) + 1)
            apd.hhTabBarView.updateBadge(forTabIndex: 4, withValue: Int(arc4random()%30) + 1)
        } else {
            //Setting 0 will hide the Badge.
            apd.hhTabBarView.updateBadge(forTabIndex: 0, withValue: 0)
            apd.hhTabBarView.updateBadge(forTabIndex: 2, withValue: 0)
            apd.hhTabBarView.updateBadge(forTabIndex: 3, withValue: 0)
            apd.hhTabBarView.updateBadge(forTabIndex: 4, withValue: 0)
        }
    }
    
    @IBAction func actionLockUnlockLastTab(_ sender: UISwitch) {
        if sender.isOn {
            apd.hhTabBarView.lockTabIndexes = [4]
        } else {
            apd.hhTabBarView.lockTabIndexes = []
        }
    }
    
    @IBAction func actionShowTabChangeAnimation(_ sender: UISwitch) {
        if sender.isOn {
            apd.hhTabBarView.tabChangeAnimationType = .shake
        } else {
            apd.hhTabBarView.tabChangeAnimationType = .none
        }
    }
}
