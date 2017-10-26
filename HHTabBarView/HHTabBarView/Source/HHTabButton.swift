//
//  HHTabButton.swift
//  HHTabBarView
//
//  Created by Hemang Shah on 7/17/17.
//  Copyright © 2017 Hemang Shah. All rights reserved.
//

import UIKit

//Various animations when HHTabButton (tab) changes.
internal extension HHTabButton {

    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.15
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.15
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.05
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
}

///Set Background Color for various UIButton states.
public extension HHTabButton {
   public func setHHTabBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
        self.setBackgroundImage(colorImage, for: .highlighted)
    }
}

///This is to show tabs inside the HHTabBarView. As it's subclassed of UIButton you can configure it as much as iOS supports.
public class HHTabButton: UIButton {
    
    ///Unique index of tabs. (Should be start with 0)
    public var tabIndex:Int = 0
    
    ///To set badge value.
    internal var badgeValue: Int = 0 {
        willSet {
            addBadgeView()
        } didSet {
            updateBadgeView()
        }
    }
    
    ///Configure badge Label. Should be configure only after setting tabs array to HHTabBarView.
    public var badgeLabel: HHTabLabel?
    
    //MARK:Init
    ///initialize HHTabButton. Useful if wants to show titles and images in tabs.
    required convenience public init(withTitle tabTitle:String, tabImage: UIImage, index:Int) {
        self.init(frame: CGRect.zero)
        setupButton(withTitle: tabTitle, tabImage: tabImage, index: index)
    }
    
    ///initialize HHTabButton with tabImage. Useful if only wants to show images in tabs.
    required convenience public init(tabImage: UIImage, index:Int) {
        self.init(frame: CGRect.zero)
        setupButton(withTitle: nil, tabImage: tabImage, index: index)
    }
    
    ///initialize HHTabButton with tabTitle. Useful if only wants to show titles in tabs.
    required convenience public init(withTitle tabTitle:String, index:Int) {
        self.init(frame: CGRect.zero)
        setupButton(withTitle: tabTitle, tabImage: nil, index: index)
    }
    
    //A common method to setup HHTabButton from customized inits.
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
    
    //This is to add BadgeView within the HHTabButton. See badgeValue var to understand the usage.
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
    
    //This is to update BadgeView within the HHTabButton. See badgeValue var to understand the usage.
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
    
    //MARK: Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
