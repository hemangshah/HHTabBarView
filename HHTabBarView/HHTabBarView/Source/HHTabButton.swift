//
//  HHTabButton.swift
//  HHTabBarView
//
//  Created by Hemang Shah on 7/17/17.
//  Copyright © 2017 Hemang Shah. All rights reserved.
//

import UIKit

public extension UIButton {
   public func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
        self.setBackgroundImage(colorImage, for: .highlighted)
    }
}

public class HHTabButton: UIButton {
    
    public var tabIndex:Int = 0
    
    public var badgeValue: Int = 0 {
        willSet {
            addBadgeView()
        } didSet {
            updateBadgeView()
        }
    }
    
    public var badgeLabel: HHTabLabel?
    
    //Init
    required
    convenience public init(withTitle tabTitle:String, tabImage: UIImage, index:Int) {
        self.init(frame: CGRect.zero)
        setupButton(withTitle: tabTitle, tabImage: tabImage, index: index)
    }
    
    required
    convenience public init(tabImage: UIImage, index:Int) {
        self.init(frame: CGRect.zero)
        setupButton(withTitle: nil, tabImage: tabImage, index: index)
    }
    
    required
    convenience public init(withTitle tabTitle:String, index:Int) {
        self.init(frame: CGRect.zero)
        setupButton(withTitle: tabTitle, tabImage: nil, index: index)
    }
    
    fileprivate func setupButton(withTitle tabTitle: String?, tabImage: UIImage?, index: Int) {
        self.backgroundColor = UIColor.clear
        
        if let title = tabTitle {
            self.setTitle(title, for: .normal)
            self.setTitleColor(.black, for: .normal)
        }
        
        if let image = tabImage {
            self.setImage(image, for: .normal)
        }
        
        self.autoresizingMask = [.flexibleWidth, .flexibleLeftMargin, .flexibleRightMargin, .flexibleHeight]
        self.tabIndex = index
    }
    
    fileprivate func addBadgeView() -> Void {
        
        //If badge label is already created, no need to recreate.
        guard badgeLabel == nil else {
            return
        }
        
        let badgeSize: CGFloat = 20.0
        let margin: CGFloat = 3.0
        badgeLabel = HHTabLabel.init(frame: CGRect.init(x: self.frame.size.width - (badgeSize + margin), y: margin, width: badgeSize, height: badgeSize))
        badgeLabel!.isHidden = true //By default.
        self.addSubview(badgeLabel!)
    }
    
    fileprivate func updateBadgeView() -> Void {
        
        if let label = badgeLabel {
            
            if badgeValue <= 0 {
                label.isHidden = true
                label.text = ""
                badgeLabel!.isHidden = true
            } else {
                label.isHidden = false
                label.text = String(badgeValue)
                badgeLabel!.isHidden = false
            }
            
        }
        
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
