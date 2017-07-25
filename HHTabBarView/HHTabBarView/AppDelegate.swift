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
    //Step by Step
    //1
    let tabbarController = UITabBarController.init()
    let hhTabBarViewTag = 1234 //Define a unique tag for the HHTabBarView.
    
    //2
    func setupUITabBarController() -> Void {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let navigationController1: UINavigationController = UINavigationController.init(rootViewController: storyboard.instantiateViewController(withIdentifier: "FirstViewControllerID"))
        navigationController1.title = "VC1" //This is for tabbar, will not show in UI
        
        let navigationController2: UINavigationController = UINavigationController.init(rootViewController: storyboard.instantiateViewController(withIdentifier: "SecondViewControllerID"))
        navigationController2.title = "VC2"  //This is for tabbar, will not show in UI
        
        tabbarController.setViewControllers([navigationController1, navigationController2], animated: true)
    }
    
    //3
    func setupCustomHHTabBarView() -> Void {
        //Step 1: Setup iOS default UITabBarController for Navigations and ViewControllers.
        setupUITabBarController()
        
        //Step 2: Setup HHTabBarView
        let hhTabbarView = HHTabBarView.init(withReferenceUITabBarController: tabbarController)
        hhTabbarView.tag = hhTabBarViewTag
        
        //Default & Selected Background Color
        let defaultTabColor = UIColor.white
        let selectedTabColor = UIColor.init(red: 234/255, green: 218/255, blue: 195/255, alpha: 1.0)
        
        //Create Custom Tabs
        let t1 = HHTabButton.init(withTitle: "Calendar", tabImage: UIImage.init(named: "Calendar")!, index: 0)
        t1.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        t1.setBackgroundColor(color: defaultTabColor, forState: .normal)
        t1.setBackgroundColor(color: selectedTabColor, forState: .selected)
        
        let t2 = HHTabButton.init(withTitle: "Refresh", tabImage: UIImage.init(named: "Refresh")!, index: 1)
        t2.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        t2.setBackgroundColor(color: defaultTabColor, forState: .normal)
        t2.setBackgroundColor(color: selectedTabColor, forState: .selected)
        
        //Create Array of Custom Tabs
        var arrayTabs = Array<HHTabButton>()
        arrayTabs.append(t1)
        arrayTabs.append(t2)
        
        //Set Custom Tabs
        hhTabbarView.tabBarTabs = arrayTabs
        
        //Set Default Index for a Tab.
        hhTabbarView.defaultIndex = 1
        
        //Handle Tab Changes
        hhTabbarView.onTabTapped = { (tabIndex) in
            print("Selected Tab Index:\(tabIndex)")
        }
    }
    
    //4
    //MARK: App Life Cycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //4.1
        //Setup HHTabBarView
        setupCustomHHTabBarView()
        
        //4.2
        //Setup Application Window
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.tabbarController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    //5
    func hideTabBar() -> Void {
        //You can add animations for hide/show
        let hhTabBar = self.tabbarController.view.viewWithTag(hhTabBarViewTag)!
        hhTabBar.isHidden = true
        self.tabbarController.tabBar.isHidden = true
    }
    
    func showTabBar() -> Void {
        //You can add animations for hide/show
        let hhTabBar = self.tabbarController.view.viewWithTag(hhTabBarViewTag)!
        hhTabBar.isHidden = false
        self.tabbarController.tabBar.isHidden = false
    }

    /////End ------ SETUP HHTabBarView ------
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
