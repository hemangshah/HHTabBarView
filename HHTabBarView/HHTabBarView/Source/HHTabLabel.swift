//
//  HHTabLabel.swift
//  HHTabBarView
//
//  Created by Hemang Shah on 7/26/17.
//  Copyright © 2017 Hemang Shah. All rights reserved.
//

import UIKit

///This is to show badge inside the HHTabButton (i.e. HHTabBarView's tab). As it's subclassed of UILabel you can configure it as much as iOS supports.
public class HHTabLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        layer.cornerRadius = frame.size.width/2.0
        layer.masksToBounds = true
        textColor = .white
        textAlignment = .center
        font = UIFont.init(name: "Helvetica-Light", size: 10.0)
        adjustsFontSizeToFitWidth = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
