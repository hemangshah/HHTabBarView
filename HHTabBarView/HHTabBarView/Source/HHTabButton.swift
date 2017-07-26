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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
