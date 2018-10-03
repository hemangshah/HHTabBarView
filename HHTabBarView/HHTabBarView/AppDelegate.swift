//
//  AppDelegate.swift
//  HHTabBarView
//
//  Created by Hemang Shah on 7/17/17.
//  Copyright © 2017 Hemang Shah. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /////Start ------ Setup HHTabBarView ------
    
    //1
    //Initialize and keeping reference of HHTabBarView.
    let hhTabBarView = HHTabBarView.shared
    
    //Keeping reference of iOS default UITabBarController.
    let referenceUITabBarController = HHTabBarView.shared.referenceUITabBarController
    
    //2
    func setupReferenceUITabBarController() {
        
        //Creating a storyboard reference
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        //First and Second Tab ViewControllers will be taken from the UIStoryBoard
        //Creating navigation controller for navigation inside the first tab.
        let navigationController1: UINavigationController = UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "FirstViewControllerID"))
        
        //Creating navigation controller for navigation inside the second tab.
        let navigationController2: UINavigationController = UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "SecondViewControllerID"))
        
        //Third, Fourth and Fifth will be created runtime.
        let sofaViewController = UIViewController()
        sofaViewController.title = "Sofa"
        sofaViewController.view.backgroundColor = .white
        let sofaNavigationController: UINavigationController = UINavigationController(rootViewController: sofaViewController)
        
        let targetViewController = UIViewController()
        targetViewController.title = "Target"
        targetViewController.view.backgroundColor = .white
        let targetNavigationController: UINavigationController = UINavigationController(rootViewController: targetViewController)
        
        let umbrellaViewController = UIViewController()
        umbrellaViewController.title = "Umbrella"
        umbrellaViewController.view.backgroundColor = .white
        let umbrellaNavigationController: UINavigationController = UINavigationController(rootViewController: umbrellaViewController)
        
        //Update referenced TabbarController with your viewcontrollers
        referenceUITabBarController.setViewControllers([navigationController1, navigationController2, sofaNavigationController, targetNavigationController, umbrellaNavigationController], animated: false)
    }
    
    //3
    func setupHHTabBarView() {
        
        //Default & Selected Background Color
        let defaultTabColor = UIColor.black.withAlphaComponent(0.8)
        let selectedTabColor = UIColor(red: 28/255, green: 158/255, blue: 247/255, alpha: 1.0)
        let tabFont = UIFont.init(name: "Helvetica-Light", size: 12.0)
        let spacing: CGFloat = 3.0
        
        //Create Custom Tabs
        //Note: As tabs are subclassed of UIButton so you can modify it as much as possible.
        
        let titles = ["Location", "Refresh", "Sofa", "Target", "Umbrella"]
        let icons = [UIImage(named: "location-pin")!, UIImage(named: "refresh")!, UIImage(named: "sofa")!, UIImage(named: "target")!, UIImage(named: "umbrella")!]
        var tabs = [HHTabButton]()
        
        for index in 0...4 {
            let tab = HHTabButton(withTitle: titles[index], tabImage: icons[index], index: index)
            tab.titleLabel?.font = tabFont
            tab.setHHTabBackgroundColor(color: defaultTabColor, forState: .normal)
            tab.setHHTabBackgroundColor(color: selectedTabColor, forState: .selected)
            tab.imageToTitleSpacing = spacing
            tab.imageVerticalAlignment = .top
            tab.imageHorizontalAlignment = .center
            tabs.append(tab)
        }
        
        //Set HHTabBarView position.
        hhTabBarView.tabBarViewPosition = .bottom
        
        //Set this value according to your UI requirements.
        hhTabBarView.tabBarViewTopPositionValue = 64

        //Set Default Index for HHTabBarView.
        hhTabBarView.tabBarTabs = tabs
        
        // To modify badge label.
        // Note: You should only modify badgeLabel after assigning tabs array.
        // Example:
        //t1.badgeLabel?.backgroundColor = .white
        //t1.badgeLabel?.textColor = selectedTabColor
        //t1.badgeLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        //Handle Tab Change Event
        hhTabBarView.defaultIndex = 0
        
        //Show Animation on Switching Tabs
        hhTabBarView.tabChangeAnimationType = .none
        
        //Handle Tab Changes
        hhTabBarView.onTabTapped = { (tabIndex) in
            print("Selected Tab Index:\(tabIndex)")
        }
    }
    
    //4
    // MARK: App Life Cycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Setup HHTabBarView
        setupReferenceUITabBarController()
        setupHHTabBarView()
        
        //This is important.
        //Setup Application Window
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = referenceUITabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

    /////End ------ SETUP HHTabBarView ------
    
    
    func applicationWillResignActive(_ application: UIApplication) { }
    func applicationDidEnterBackground(_ application: UIApplication) { }
    func applicationWillEnterForeground(_ application: UIApplication) { }
    func applicationDidBecomeActive(_ application: UIApplication) { }
    func applicationWillTerminate(_ application: UIApplication) {  }
}
