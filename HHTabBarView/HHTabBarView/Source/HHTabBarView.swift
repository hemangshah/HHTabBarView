//
//  HHTabBarView.swift
//  HHTabBarView
//
//  Created by Hemang Shah on 7/17/17.
//  Copyright © 2017 Hemang Shah. All rights reserved.
//

import UIKit

private let hhTabBarViewHeight: CGFloat = 49.0

///Animation Types for Tab Changes.
public enum HHTabBarTabChangeAnimationType {
    case flash, shake, pulsate, none
}

///Position Types for HHTabBarView.
public enum HHTabBarViewPosition {
    case top, bottom
}

private extension UIScreen {
    class var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    class var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
}

///Easily configured HHTabBarView class to replace the iOS default UITabBarController.
public class HHTabBarView: UIView {
    
    ///Singleton
    public static var shared = HHTabBarView()
    
    ///For Internal Navigation
    private(set) public var referenceUITabBarController =  UITabBarController()
    ///Current Tab Index: Internal Usage Only.
    private(set) var currentTabIndex: Int = 0
    
    // MARK: Setters
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
        _ = self.subviews.map { $0.transform = t }
    }
    
    ///Reverse the Tabs from LeftToRight [Usage English/Arabic UI]
    public func leftToRight() {
        let t = CGAffineTransform.init(scaleX: 1, y: 1)
        self.transform = t
        _ = self.subviews.map { $0.transform = t }
    }
    
    ///Completion Handler for Tab Changes
    public var onTabTapped:((_ tabIndex: Int, _ isSameTab: Bool, _ controller: Any?) -> Void)? = nil
    
    // MARK: Init
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required
    convenience public init() {
        //Set frame for HHTabBarView.
        let rect = CGRect.init(x: 0.0, y: 0.0, width: UIScreen.width, height: hhTabBarViewHeight)
        self.init(frame: rect)
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
    
    public override func layoutSubviews() {
        frame = getHHTabBarViewFrame()
    }
    
    ///Helper to Select a Particular Tab.
    public func selectTabAtIndex(withIndex tabIndex: Int) {
        // Tab Selection/Deselection
        _ = tabBarTabs.map { $0.isSelected = ($0.tabIndex == tabIndex) ? true : false}
        // Apply Tab Changes in UITabBarController
        referenceUITabBarController.selectedIndex = tabIndex
        // Lock or Unlock the Tabs if requires.
        lockUnlockTabs()
        
        currentTabIndex = tabIndex
    }
    
    /// A convenience method to show or hide HHTabBarView.
    public func toggleShowOrHide() {
        self.isHidden = !isHidden
    }
    
    // Overriding Default Properties
    /// To hide the HHTabBarView.
    override public var isHidden: Bool {
        willSet {
            self.referenceUITabBarController.tabBar.isHidden = !isHidden
        }
    }
    
    /// Lock Current tab, if don't want to select the same tab again.
    public func lockCurrentTab() {
        for (index, tab) in tabBarTabs.enumerated() {
            if index == currentTabIndex {
                if let controllers = self.referenceUITabBarController.viewControllers, let navcon = controllers[currentTabIndex] as? UINavigationController {
                    if navcon.viewControllers.count == 1 {
                        tab.isUserInteractionEnabled = false
                        break
                    }
                }
            }
        }
    }
    
    /// Unlock all of the tabs at once.
    public func unlockAllTabs(ignoreAlreadyLocked: Bool = false) {
        unlockAllTabs(); if ignoreAlreadyLocked { lockSpecifiedTab() }
    }
    
    // MARK: Helpers
    private func getHHTabBarViewFrame() -> CGRect {
        let screentWidth = UIScreen.width
        let screentHeight = UIScreen.height
        var tabBarHeight = hhTabBarViewHeight
        
        if tabBarViewPosition == .top {
            return CGRect.init(x: 0.0, y: tabBarViewTopPositionValue, width: screentWidth, height: tabBarHeight)
        } else {
            if #available(iOS 11.0, *) {
                let bottomPadding = referenceUITabBarController.tabBar.safeAreaInsets.bottom
                tabBarHeight += bottomPadding
            }
            return CGRect.init(x: 0.0, y: (screentHeight - tabBarHeight), width: screentWidth, height: tabBarHeight)
        }
    }

    private func isTabsAvailable() -> Bool {
        return tabBarTabs.isEmpty ? false : true
    }
    
    private func unlockAllTabs() {
        _ = tabBarTabs.map { $0.isUserInteractionEnabled = true }
    }
    
    private func lockUnlockTabs() {
        //Unlock All Tabs Before Locking.
        unlockAllTabs()
        //Then Lock the provided Tab Indexes.
        lockSpecifiedTab()
    }
    
    private func lockSpecifiedTab() {
        if !lockTabIndexes.isEmpty {
            for index in lockTabIndexes {
                let hhTabButton = tabBarTabs[index]
                hhTabButton.isUserInteractionEnabled = false
            }
        }
    }
    
    private func createTabs() {
        var xPos: CGFloat = 0.0
        let yPos: CGFloat = 0.0
        let width = frame.size.width/CGFloat(tabBarTabs.count)
        let height = frame.size.height
        for hhTabButton in tabBarTabs {
            hhTabButton.frame = CGRect.init(x: xPos, y: yPos, width: width, height: height)
            hhTabButton.addTarget(self, action: #selector(actionTabTapped(tab:)), for: .touchUpInside)
            hhTabButton.badgeValue = 0
            addSubview(hhTabButton)
            xPos += width
        }
        defaultIndex = 0
    }
    
    //Actions
    @objc private func actionTabTapped(tab: HHTabButton) {
        let tappedTabIndex = tab.tabIndex
        var isSameTab: Bool = false
        let controller = referenceUITabBarController.viewControllers?[tappedTabIndex]
        if currentTabIndex == tappedTabIndex {
            isSameTab = true
        } else {
            isSameTab = false
            animateTabBarButton(tabBarButton: tab)
            selectTabAtIndex(withIndex: tab.tabIndex)
        }
        onTabTapped?(tappedTabIndex, isSameTab, controller)
    }
    
    //Perform Animation on Tab Changes.
    private func animateTabBarButton(tabBarButton: HHTabButton) {
        switch self.tabChangeAnimationType {
            case .flash: tabBarButton.flash()
            case .shake: tabBarButton.shake()
            case .pulsate: tabBarButton.pulsate()
            default: break
        }
    }
}
