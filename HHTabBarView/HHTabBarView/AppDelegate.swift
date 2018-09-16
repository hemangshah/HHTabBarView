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
        self.referenceUITabBarController.setViewControllers([navigationController1, navigationController2, sofaNavigationController, targetNavigationController, umbrellaNavigationController], animated: false)
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
        
        let t1 = HHTabButton(withTitle: "Location", tabImage: UIImage(named: "location-pin")!, index: 0)
        t1.titleLabel?.font = tabFont
        t1.setHHTabBackgroundColor(color: defaultTabColor, forState: .normal)
        t1.setHHTabBackgroundColor(color: selectedTabColor, forState: .selected)
        t1.imageToTitleSpacing = spacing
        t1.imageVerticalAlignment = .top
        t1.imageHorizontalAlignment = .center
        
        let t2 = HHTabButton(withTitle: "Refresh", tabImage: UIImage(named: "refresh")!, index: 1)
        t2.titleLabel?.font = tabFont
        t2.setHHTabBackgroundColor(color: defaultTabColor, forState: .normal)
        t2.setHHTabBackgroundColor(color: selectedTabColor, forState: .selected)
        t2.imageToTitleSpacing = spacing
        t2.imageVerticalAlignment = .top
        t2.imageHorizontalAlignment = .center
        
        let t3 = HHTabButton(withTitle: "Sofa", tabImage: UIImage(named: "sofa")!, index: 2)
        t3.titleLabel?.font = tabFont
        t3.setHHTabBackgroundColor(color: defaultTabColor, forState: .normal)
        t3.setHHTabBackgroundColor(color: selectedTabColor, forState: .selected)
        t3.imageToTitleSpacing = spacing
        t3.imageVerticalAlignment = .top
        t3.imageHorizontalAlignment = .center
        
        let t4 = HHTabButton(withTitle: "Target", tabImage: UIImage(named: "target")!, index: 3)
        t4.titleLabel?.font = tabFont
        t4.setHHTabBackgroundColor(color: defaultTabColor, forState: .normal)
        t4.setHHTabBackgroundColor(color: selectedTabColor, forState: .selected)
        t4.imageToTitleSpacing = spacing
        t4.imageVerticalAlignment = .top
        t4.imageHorizontalAlignment = .center
        
        let t5 = HHTabButton(withTitle: "Umbrella", tabImage: UIImage(named: "umbrella")!, index: 4)
        t5.titleLabel?.font = tabFont
        t5.setHHTabBackgroundColor(color: defaultTabColor, forState: .normal)
        t5.setHHTabBackgroundColor(color: selectedTabColor, forState: .selected)
        t5.imageToTitleSpacing = spacing
        t5.imageVerticalAlignment = .top
        t5.imageHorizontalAlignment = .center
        
        //Set HHTabBarView position.
        self.hhTabBarView.tabBarViewPosition = .bottom
        
        //Set this value according to your UI requirements.
        self.hhTabBarView.tabBarViewTopPositionValue = 64

        //Set Default Index for HHTabBarView.
        self.hhTabBarView.tabBarTabs = [t1, t2, t3, t4, t5]
        
        //You should modify badgeLabel after assigning tabs array.
        //t1.badgeLabel?.backgroundColor = .white
        //t1.badgeLabel?.textColor = selectedTabColor
        //t1.badgeLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        //Handle Tab Change Event
        self.hhTabBarView.defaultIndex = 0
        
        //Show Animation on Switching Tabs
        self.hhTabBarView.tabChangeAnimationType = .none
        
        //Handle Tab Changes
        self.hhTabBarView.onTabTapped = { (tabIndex) in
            print("Selected Tab Index:\(tabIndex)")
        }
    }
    
    //4
    //MARK: App Life Cycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Setup HHTabBarView
        self.setupReferenceUITabBarController()
        self.setupHHTabBarView()
        
        //This is important.
        //Setup Application Window
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.referenceUITabBarController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    //5
    //MARK: Show/Hide HHTabBarView
    func hideTabBar() {
        self.hhTabBarView.isHidden = true
    }
    
    func showTabBar() {
        self.hhTabBarView.isHidden = false
    }

    /////End ------ SETUP HHTabBarView ------
    
    
    func applicationWillResignActive(_ application: UIApplication) { }
    func applicationDidEnterBackground(_ application: UIApplication) { }
    func applicationWillEnterForeground(_ application: UIApplication) { }
    func applicationDidBecomeActive(_ application: UIApplication) { }
    func applicationWillTerminate(_ application: UIApplication) {  }
}
