//
//  HHTabBarView.swift
//  HHTabBarView
//
//  Created by Hemang Shah on 7/17/17.
//  Copyright © 2017 Hemang Shah. All rights reserved.
//

import UIKit

fileprivate let hhTabBarViewHeight: CGFloat = 49.0

///Animation Types for Tab Changes.
public enum HHTabBarTabChangeAnimationType {
    case flash, shake, pulsate, none
}

///Position Types for HHTabBarView.
public enum HHTabBarViewPosition {
    case top, bottom
}

///Easily configured HHTabBarView class to replace the iOS default UITabBarController.
public class HHTabBarView: UIView {
    
    ///Singleton
    public static var shared = HHTabBarView()
    
    ///For Internal Navigation
    private(set) public var referenceUITabBarController =  UITabBarController()
    
    //MARK: Setters
    ///Animation Type. Default: none.
    public var tabChangeAnimationType: HHTabBarTabChangeAnimationType = .none

    ///TabBarView Position. Default: bottom. Also, don't forget to set 'tabBarViewTopPositionValue' if tabBarViewPosition = 'top'.
    public var tabBarViewPosition: HHTabBarViewPosition = .bottom
    
    /// If tabBarViewPosition = top then you should set it according to your UI requirements.
    public var tabBarViewTopPositionValue: CGFloat = 64.0
    
    ///Set HHTabButton for HHTabBarView.
    public var tabBarTabs = [HHTabButton]() {
        didSet {
            createTabs()
        }
    }
    
    ///Set the default tab for HHTabBarView.
    public var defaultIndex = 0 {
        didSet {
            if isTabsAvailable() {
                selectTabAtIndex(withIndex: defaultIndex)
            }
        }
    }
    
    //Lock Index for Tabs
    ///Specify indexes of tabs to lock. [0, 2, 3]
    public var lockTabIndexes = [Int]() {
        didSet {
            lockUnlockTabs()
        }
    }
    
    ///Update Badge Value for Specific Tab.
    public func updateBadge(forTabIndex index: Int, withValue value: Int) {
        if isTabsAvailable() {
            let hhTabButton = tabBarTabs[index]
            hhTabButton.badgeValue = value
        }
    }
    
    ///Reverse the Tabs from RightToLeft [Usage English/Arabic UI]
    public func rightToLeft() {
        let t = CGAffineTransform.init(scaleX: -1, y: -1)
        self.transform = t
        _ = self.subviews.map {$0.transform = t }
    }
    
    ///Reverse the Tabs from LeftToRight [Usage English/Arabic UI]
    public func leftToRight() {
        let t = CGAffineTransform.init(scaleX: 1, y: 1)
        self.transform = t
        _ = self.subviews.map {$0.transform = t }
    }
    
    ///Completion Handler for Tab Changes
    public var onTabTapped:((_ tabIndex: Int) -> ())! = nil
    
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
        self.init(frame: CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: hhTabBarViewHeight))
        //You can configure it to any background color you want.
        backgroundColor = .clear
        //For Portrait/Landscape.
        autoresizingMask = [.flexibleWidth, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        //Adding to UITabBarController's subview.
        referenceUITabBarController.view.addSubview(self)
        //This is important otherwise tabBar will be visible if tabChangeAnimationType = .flash
        referenceUITabBarController.tabBar.isHidden = true
        referenceUITabBarController.tabBar.alpha = 0.0
    }
    
    //HHTabBarViewFrame Frame
    fileprivate func getHHTabBarViewFrame() -> CGRect {
        let screenSize = UIScreen.main.bounds.size
        let screentHeight = screenSize.height
        let screentWidth = screenSize.width
        var tabBarHeight = hhTabBarViewHeight

        if self.tabBarViewPosition == .top {
            return CGRect.init(x: 0.0, y: tabBarViewTopPositionValue, width: screentWidth, height: tabBarHeight)
        } else {
            if #available(iOS 11.0, *) {
                let bottomPadding = referenceUITabBarController.tabBar.safeAreaInsets.bottom
                tabBarHeight += bottomPadding
            }
            return CGRect.init(x: 0.0, y: (screentHeight - tabBarHeight), width: screentWidth, height: tabBarHeight)
        }
    }
    
    //UI Updates
    public override func layoutSubviews() {
        frame = getHHTabBarViewFrame()
    }
    
    //Helper to Select a Particular Tab.
    public func selectTabAtIndex(withIndex tabIndex: Int) {
        // Tab Selection/Deselection
        _ = tabBarTabs.map {$0.isSelected = ($0.tabIndex == tabIndex) ? true : false}
        // Apply Tab Changes in UITabBarController
        referenceUITabBarController.selectedIndex = tabIndex
        // Lock or Unlock the Tabs if requires.
        lockUnlockTabs()
        // Disable interaction for the current tab.
        let currentHHTabButton = tabBarTabs[tabIndex]
        currentHHTabButton.isUserInteractionEnabled = false
    }
    
    ///A convenience method to show or hide HHTabBarView.
    public func toggleShowOrHide() {
        self.isHidden = !isHidden
    }
    
    //Check if Tabs are created.
    fileprivate func isTabsAvailable() -> Bool {
        return tabBarTabs.isEmpty ? false : true
    }
    
    //Lock or Unlock Tabs if requires.
    fileprivate func lockUnlockTabs() {
        //Unlock All Tabs Before Locking.
        _ = tabBarTabs.map {$0.isUserInteractionEnabled = true}

        //Then Lock the provided Tab Indexes.
        if !lockTabIndexes.isEmpty {
            for index in lockTabIndexes {
                let hhTabButton = tabBarTabs[index]
                hhTabButton.isUserInteractionEnabled = false
            }
        }
    }
    
    //Create Tabs UI
    fileprivate func createTabs() {

        var xPos: CGFloat = 0.0
        let yPos: CGFloat = 0.0
        
        let width = CGFloat(frame.size.width)/CGFloat(tabBarTabs.count)
        let height = frame.size.height

        for hhTabButton in self.tabBarTabs {
            hhTabButton.frame = CGRect.init(x: xPos, y: yPos, width: width, height: height)
            hhTabButton.addTarget(self, action: #selector(actionTabTapped(tab:)), for: .touchUpInside)
            hhTabButton.badgeValue = 0 //This will create HHTabLabel inside the HHTabButton
            addSubview(hhTabButton)
            xPos = xPos + width
        }
        
        //By default index.
        self.defaultIndex = 0
    }
    
    //Actions
    @objc fileprivate func actionTabTapped(tab: HHTabButton) {
        if onTabTapped != nil {
            animateTabBarButton(tabBarButton: tab)
            selectTabAtIndex(withIndex: tab.tabIndex)
            onTabTapped(tab.tabIndex)
        }
    }
    
    //Perform Animation on Tab Changes.
    fileprivate func animateTabBarButton(tabBarButton: HHTabButton) {
        switch self.tabChangeAnimationType {
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
