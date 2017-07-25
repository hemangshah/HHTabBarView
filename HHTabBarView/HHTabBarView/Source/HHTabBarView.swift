//
//  HHTabBarView.swift
//  HHTabBarView
//
//  Created by Hemang Shah on 7/17/17.
//  Copyright © 2017 Hemang Shah. All rights reserved.
//

import UIKit

fileprivate let HHTabBarViewHeight = CGFloat(49.0)

public class HHTabBarView: UIView {
    
    //Singleton
    static var shared = HHTabBarView.init()
    
    //For internal navigation
    var referenceUITabBarController =  UITabBarController.init()
    
    //Detect Tab Changes
    public var onTabTapped:((_ tabIndex:Int) -> ())! = nil
    
    //Init
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
        self.backgroundColor = .clear
        self.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        referenceUITabBarController.view.addSubview(self)
    }
    
    //HHTabBarViewFrame Frame
    fileprivate func HHTabBarViewFrame() -> CGRect {
        let screenSize = UIScreen.main.bounds.size
        let screentHeight = screenSize.height
        let screentWidth = screenSize.width
        return CGRect.init(x: 0.0, y: (screentHeight - HHTabBarViewHeight), width: screentWidth, height: HHTabBarViewHeight)
    }
    
    //Setter
    ///Set HHTabButton for HHTabBarView.
    var tabBarTabs = Array<HHTabButton>() {
        didSet {
            createTabs()
        }
    }
    
    ///Set the default tab for HHTabBarView.
    var defaultIndex = 0 {
        didSet {
            if isTabsCreated() {
                selectTabAtIndex(withIndex: defaultIndex)
            }
        }
    }
    
    //UI Updates
    public override func layoutSubviews() {
        self.frame = HHTabBarViewFrame()
    }
    
    //Helper to Select a Particular Tab.
    fileprivate func selectTabAtIndex(withIndex tabIndex: Int) {

        for hhTabButton in tabBarTabs {
            if hhTabButton.tabIndex == tabIndex {
                hhTabButton.isSelected = true
                hhTabButton.isUserInteractionEnabled = false
            } else {
                hhTabButton.isSelected = false
                hhTabButton.isUserInteractionEnabled = true
            }
        }
        
        // Apply tab changes
        referenceUITabBarController.selectedIndex = tabIndex
    }
    
    fileprivate func isTabsCreated() -> Bool {
        if !tabBarTabs.isEmpty {
            return true
        }
        return false
    }
    
    //Create Tab UI
    fileprivate func createTabs() {
        
        var xPos: CGFloat = 0.0
        let yPos: CGFloat = 0.0
        
        let width = CGFloat(self.frame.size.width)/CGFloat(tabBarTabs.count)
        let height = self.frame.size.height
        
        for hhTabButton in tabBarTabs {
            hhTabButton.frame = CGRect.init(x: xPos, y: yPos, width: width, height: height)
            hhTabButton.addTarget(self, action: #selector(actionTabTapped(tab:)), for: .touchUpInside)
            self.addSubview(hhTabButton)
            xPos = xPos + width
        }
        
        //By default index.
        self.defaultIndex = 0
    }
    
    //Actions
    @objc fileprivate func actionTabTapped(tab: HHTabButton) {
        if onTabTapped != nil {
            self.selectTabAtIndex(withIndex: tab.tabIndex)
            self.onTabTapped(tab.tabIndex)
        }
    }
    
    override public var isHidden: Bool {
        willSet {
            self.referenceUITabBarController.tabBar.isHidden = !isHidden
        }
    }
}
