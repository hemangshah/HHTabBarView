//
//  HHTabBarView.swift
//  HHTabBarView
//
//  Created by Hemang Shah on 7/17/17.
//  Copyright © 2017 Hemang Shah. All rights reserved.
//

import UIKit

internal let HHTabBarViewHeight = CGFloat(49.0)

///Animation Types for Tab Changes.
public enum HHTabBarTabChangeAnimationType {
    case flash, shake, pulsate, none
}

///Easily configured HHTabBarView class to replace the iOS default UITabBarController.
public class HHTabBarView: UIView {
    
    ///Singleton
    public static var shared = HHTabBarView.init()
    
    ///For Internal Navigation
    public var referenceUITabBarController =  UITabBarController.init()
    
    //MARK: Setters
    ///Animation Type
    public var tabChangeAnimationType: HHTabBarTabChangeAnimationType = .none
    
    ///Set HHTabButton for HHTabBarView.
    public var tabBarTabs = Array<HHTabButton>() {
        didSet {
            createTabs()
        }
    }
    
    ///Set the default tab for HHTabBarView.
    public var defaultIndex = 0 {
        didSet {
            if areTabsCreated() {
                selectTabAtIndex(withIndex: defaultIndex)
            }
        }
    }
    
    //Lock Index for Tabs
    ///Specify indexes of tabs to lock. [0, 2, 3]
    public var lockTabIndexes = Array<Int>() {
        didSet {
            lockUnlockTabs()
        }
    }
    
    ///Update Badge Value for Specific Tab.
    public func updateBadge(forTabIndex index: Int, withValue value: Int) -> Void {
        if areTabsCreated() {
            let hhTabButton = tabBarTabs[index]
            hhTabButton.badgeValue = value
        }
    }
    
    ///Completion Handler for Tab Changes
    public var onTabTapped:((_ tabIndex:Int) -> ())! = nil
    
    //MARK: Init
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required
    convenience public init() {
        self.init(frame: CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: HHTabBarViewHeight))
        //You can configure it to any background color you want.
        self.backgroundColor = .clear
        //For Portrait/Landscape.
        self.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        //Adding to UITabBarController's subview.
        referenceUITabBarController.view.addSubview(self)
        //This is important otherwise tabBar will be visible if tabChangeAnimationType = .flash
        referenceUITabBarController.tabBar.isHidden = true
    }
    
    //HHTabBarViewFrame Frame
    fileprivate func HHTabBarViewFrame() -> CGRect {
        let screenSize = UIScreen.main.bounds.size
        let screentHeight = screenSize.height
        let screentWidth = screenSize.width
        return CGRect.init(x: 0.0, y: (screentHeight - HHTabBarViewHeight), width: screentWidth, height: HHTabBarViewHeight)
    }
    
    //UI Updates
    public override func layoutSubviews() {
        self.frame = HHTabBarViewFrame()
    }
    
    //Helper to Select a Particular Tab.
    fileprivate func selectTabAtIndex(withIndex tabIndex: Int) {

        // Tab Selection/Deselection
        for hhTabButton in tabBarTabs {
            
            if hhTabButton.tabIndex == tabIndex {
                hhTabButton.isSelected = true
            } else {
                hhTabButton.isSelected = false
            }
        }
        
        // Apply Tab Changes in UITabBarController
        referenceUITabBarController.selectedIndex = tabIndex
        
        // Lock or Unlock the Tabs if requires.
        lockUnlockTabs()
        
        let currentHHTabButton = tabBarTabs[tabIndex]
        currentHHTabButton.isUserInteractionEnabled = false
    }
    
    //Check if Tabs are created.
    fileprivate func areTabsCreated() -> Bool {
        if !tabBarTabs.isEmpty {
            return true
        }
        return false
    }
    
    //Lock or Unlock Tabs if requires.
    fileprivate func lockUnlockTabs() -> Void {
        
        //Unlock All Tabs Before Locking.
        for hhTabButton in tabBarTabs {
            hhTabButton.isUserInteractionEnabled = true
        }
        
        //Then Lock the provided Tab Indexes.
        if !lockTabIndexes.isEmpty {
            for index in lockTabIndexes {
                let hhTabButton = tabBarTabs [index]
                hhTabButton.isUserInteractionEnabled = false
            }
        }
    }
    
    //Create Tabs UI
    fileprivate func createTabs() {

        var xPos: CGFloat = 0.0
        let yPos: CGFloat = 0.0
        
        let width = CGFloat(self.frame.size.width)/CGFloat(tabBarTabs.count)
        let height = self.frame.size.height
        
        for hhTabButton in tabBarTabs {
            hhTabButton.frame = CGRect.init(x: xPos, y: yPos, width: width, height: height)
            hhTabButton.addTarget(self, action: #selector(actionTabTapped(tab:)), for: .touchUpInside)
            hhTabButton.badgeValue = 0 //This will create HHTabLabel inside the HHTabButton
            self.addSubview(hhTabButton)
            xPos = xPos + width
        }
        
        //By default index.
        self.defaultIndex = 0
    }
    
    //Actions
    @objc fileprivate func actionTabTapped(tab: HHTabButton) {
        if onTabTapped != nil {
            animateTabBarButton(tabBarButton: tab)
            self.selectTabAtIndex(withIndex: tab.tabIndex)
            self.onTabTapped(tab.tabIndex)
        }
    }
    
    //Perform Animation on Tab Changes.
    fileprivate func animateTabBarButton(tabBarButton: HHTabButton) {
        switch tabChangeAnimationType {
        case .flash:
            tabBarButton.flash()
            break
        case .shake:
            tabBarButton.shake()
            break
        case .pulsate:
            tabBarButton.pulsate()
            break
        default:
            break
        }
    }
    
    //Overriding Default Properties
    override public var isHidden: Bool {
        willSet {
            self.referenceUITabBarController.tabBar.isHidden = !isHidden
        }
    }
}
