![HHTabBarView](https://github.com/Tobaloidee/HHTabBarView/blob/master/logo/logotype-a.png)

A lightweight customized tabbar view.

[![Build Status](https://travis-ci.org/hemangshah/HHTabBarView.svg?branch=master)](https://travis-ci.org/hemangshah/HHTabBarView)
[![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)](https://github.com/hemangshah/HHTabBarView/blob/master/LICENSE)
[![Platform](https://img.shields.io/badge/Platforms-iOS-red.svg)](https://www.apple.com/in/ios/)
[![Swift 4.x](https://img.shields.io/badge/Swift-4.x-blue.svg)](https://swift.org/)
[![MadeWithLove](https://img.shields.io/badge/Made%20with%20%E2%9D%A4-India-green.svg)](https://madewithlove.org.in/)
[![Awesome-Swift](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/matteocrippa/awesome-swift/)

1. [Screenshots](#screenshots)
2. [Features](#features)
3. [Installation](#installation)
4. [Setup](#setup)
5. [ToDos](#todos)
6. [Credits](#credits)
7. [Thanks](#thank-you)
8. [License](#license)

## Screenshots

<table>
<tr>
<td align="center"><img src = "https://github.com/hemangshah/HHTabBarView/blob/master/Screenshots/1.png" alt = "Only Icon"></td>
<td align="center"><img src = "https://github.com/hemangshah/HHTabBarView/blob/master/Screenshots/2.png" alt = "Icon (top) with title (bottom)"></td>
<td align="center"><img src = "https://github.com/hemangshah/HHTabBarView/blob/master/Screenshots/3.png" alt = "Only Title"></td>
</tr>
<tr>
<td align="center"><img src = "https://github.com/hemangshah/HHTabBarView/blob/master/Screenshots/4.png" alt = "Icon (left) with title (right)"></td>
<td align="center"><img src = "https://github.com/hemangshah/HHTabBarView/blob/master/Screenshots/5.png" alt = "Icon (right) with title (left)"></td>
<td align="center"><img src = "https://github.com/hemangshah/HHTabBarView/blob/master/Screenshots/6.png" alt = "Icon (bottom) with title (top)"></td>
</tr>
<tr>
<td align="center"><img src = "https://github.com/hemangshah/HHTabBarView/blob/master/Screenshots/7.png" alt = "HHTabBarView top position"></td>
<td align="center"><img src = "https://github.com/hemangshah/HHTabBarView/blob/master/Screenshots/8.png" alt = "HHTabBarView top position (iPhoneX)"></td>
</tr>
<tr>
<td colspan="3" align="center"><img src = "https://github.com/hemangshah/HHTabBarView/blob/master/Screenshots/HHTabBarFlow.gif" alt = "Usage"></td>
</tr>
</table>

## Features

1. Easily Configurable and Setup. Create tabs with Title, or Image or both. 
2. Dynamic Tabs Configurations.
3. Detect Taps in a completion block.
4. Show/Hide Badge Value in individual tabs. Easily Configure as per the needs.
5. Lock/Unlock particular tabs.
6. Easily show/hide UINavigationBar and HHTabBarView.
7. Lightweight with zero dependancies.
8. Change UI of HHTabBarView (LeftToRight or RightToLeft) as per the needs.
9. Change HHTabBarView position as per UI requirements. Supports: Top and Bottom (Default). 

##### Note: I don't recommended displaying HHTabBarView at the top. It's always good at the bottom.

## Installation

1. **Manually** – Add `HHTabBarView/Source` folder to your Project. And you're good to use `HHTabBarView`.

2. **CocoaPods**: – `pod 'HHTabBarView'`
    
> You can read the [CHANGELOG](https://github.com/hemangshah/HHTabBarView/blob/master/CHANGELOG.md) file for a particular release.

## Setup

**Important**: Please note that `HHTabBarView` is currently not supports `UIStoryBoard`. Means, you will have to create `HHTabBarView` programmatically. It is advised to setup `HHTabBarView` in `AppDelegate.swift` for your easyness.

1.  Initialize and keeping reference of `HHTabBarView`. 📌
````swift
    let hhTabBarView = HHTabBarView.shared
````

2.  Keeping reference of iOS default `UITabBarController`. 📌
````swift
    let referenceTabBarController = HHTabBarView.shared.referenceUITabBarController
````
    
3. Setup referenced `UITabBarController` 📌
````swift
    func setupReferenceUITabBarController() -> Void {
        
        //Creating a storyboard reference
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        //Creating navigation controller for navigation inside the first tab.
        let navigationController1: UINavigationController = UINavigationController.init(rootViewController: storyboard.instantiateViewController(withIdentifier: "FirstViewControllerID"))
        
        //Creating navigation controller for navigation inside the second tab.
        let navigationController2: UINavigationController = UINavigationController.init(rootViewController: storyboard.instantiateViewController(withIdentifier: "SecondViewControllerID"))
        
        //Update referenced TabbarController with your viewcontrollers
        referenceTabBarController.setViewControllers([navigationController1, navigationController2], animated: false)
    }
````    
    
4. Setup `HHTabBarView` 📌
````swift
    //Update HHTabBarView reference with the tabs requires.
    func setupHHTabBarView() -> Void {
        
        //Default & Selected Background Color
        let defaultTabColor = UIColor.white
        let selectedTabColor = UIColor.init(red: 234/255, green: 218/255, blue: 195/255, alpha: 1.0)
        let tabFont = UIFont.init(name: "Helvetica-Light", size: 14.0)
        
        //Create Custom Tabs
        let t1 = HHTabButton.init(withTitle: "Calendar", tabImage: UIImage.init(named: "Calendar")!, index: 0)
        t1.titleLabel?.font = tabFont
        t1.titleLabel?.textColor = UIColor.black
        t1.setHHTabBackgroundColor(color: defaultTabColor, forState: .normal)
        t1.setHHTabBackgroundColor(color: selectedTabColor, forState: .selected)
        
        let t2 = HHTabButton.init(withTitle: "Refresh", tabImage: UIImage.init(named: "Refresh")!, index: 1)
        t2.titleLabel?.font = tabFont
        t2.titleLabel?.textColor = UIColor.black
        t2.setHHTabBackgroundColor(color: defaultTabColor, forState: .normal)
        t2.setHHTabBackgroundColor(color: selectedTabColor, forState: .selected)
        
        //Note: As HHTabButton are subclassed of UIButton so you can modify it as much as possible.
        
        //Set Custom Tabs
        hhTabBarView.tabBarTabs = [t1, t2]
        
        //Set Default Index for HHTabBarView.
        hhTabBarView.defaultIndex = 1
        
        //Show Animation on Switching Tabs
        hhTabBarView.tabChangeAnimationType = .none
        
        //Handle Tab Change Event
        hhTabBarView.onTabTapped = { (tabIndex) in
            print("Selected Tab Index:\(tabIndex)")
        }
    }
````

5. Setup `window` of your application inside the 📌
````swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Setup HHTabBarView
        setupReferenceUITabBarController()
        setupHHTabBarView()
        
        //Setup Application Window
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.referenceTabBarController
        self.window?.makeKeyAndVisible()
        
        return true
    }
````

6. Done! ✅    

<hr>

## ToDo[s]

- [x] Update README with multiple example usage and screenshots.

You can [watch](https://github.com/hemangshah/HHTabBarView/subscription) to <b>HHTabBarView</b> to see continuous updates. Stay tuned.

<b>Have an idea for improvements of this class?
Please open an [issue](https://github.com/hemangshah/HHTabBarView/issues/new).</b>
    
## Credits

<b>[Hemang Shah](https://about.me/hemang.shah)</b>

**You can shoot me an [email](http://www.google.com/recaptcha/mailhide/d?k=01IzGihUsyfigse2G9z80rBw==&c=vU7vyAaau8BctOAIJFwHVbKfgtIqQ4QLJaL73yhnB3k=) to contact.**
   
## Thank You!!

See the [contributions](https://github.com/hemangshah/HHTabBarView/blob/master/CONTRIBUTIONS.md) for details.

## License

The MIT License (MIT)

> Read the [LICENSE](https://github.com/hemangshah/HHTabBarView/blob/master/LICENSE) file for details.
