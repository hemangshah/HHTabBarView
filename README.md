# HHTabBarView
A lightweight customized tabbar view.

[![Build Status](https://travis-ci.org/hemangshah/HHTabBarView.svg?branch=master)](https://travis-ci.org/hemangshah/HHTabBarView)
![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)
![Platform](https://img.shields.io/badge/Platforms-iOS-red.svg)
![Swift 4.x](https://img.shields.io/badge/Swift-4.x-blue.svg)
![MadeWithLove](https://img.shields.io/badge/Made%20with%20%E2%9D%A4-India-green.svg)
[![Blog](https://img.shields.io/badge/Blog-iKiwiTech.com-blue.svg)](http://www.ikiwitech.com)

## Installation

1.**Manually** - Add `HHTabBarView.swift` and `HHTabButton.swift` files to your Project. 

## Setup

**Important**: Please note that `HHTabBarView` is currently not supports `UIStoryBoard` support. Means, you will have to create `HHTabBarView` programmatically.

1. It is advised to setup `HHTabBarView` in `AppDelegate.swift` for easy navigation. 📌

2. Create an instance of `UITabBarController` 📌
````
    let tabbarController = UITabBarController.init()
    let hhTabBarViewTag = 12345 //Also, define a unique tag for the HHTabBarView.
````
    
3. Setup `UITabBarController` 📌
````
    func setupUITabBarController() -> Void {        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let navigationController1: UINavigationController = UINavigationController.init(rootViewController: storyboard.instantiateViewController(withIdentifier: "FirstViewControllerID"))
        
        let navigationController2: UINavigationController = UINavigationController.init(rootViewController: storyboard.instantiateViewController(withIdentifier: "SecondViewControllerID"))        
        tabbarController.setViewControllers([navigationController1, navigationController2], animated: true)
    }
    
````    
    
4. Setup `HHTabBarView` 📌
````
    func setupHHTabBarView() -> Void {        
        //Setup
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
````

5. Setup `window` of your application inside the 📌
````
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupUITabBarController()
        setupHHTabBarView()
        
        //Setup Application Window
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.tabbarController
        self.window?.makeKeyAndVisible()
        
        return true
    }
````

6. Done! ✅    

<hr>

## ToDo[s]

🎁<b><i> [ New Features ] </i></b>🎁

- [ ] Make HHTabBarView Singleton
- [ ] More Customization Options
- [ ] Lock Tabs
- [ ] Handling of Multiple Tabs (Case: More than 5 tabs)
- [ ] Badge
- [ ] Animations
- [ ] UIStoryboard Support
- [ ] CocoaPods support

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
