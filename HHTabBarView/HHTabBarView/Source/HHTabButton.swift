//
//  HHTabButton.swift
//  HHTabBarView
//
//  Created by Hemang Shah on 7/17/17.
//  Copyright © 2017 Hemang Shah. All rights reserved.
//

import UIKit

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
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
        self.backgroundColor = UIColor.clear
        self.setTitle(tabTitle, for: .normal)
        self.setImage(tabImage, for: .normal)
        self.titleEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        self.setTitleColor(.black, for: .normal)
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
