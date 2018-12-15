//
//  HHTabButton.swift
//  HHTabBarView
//
//  Created by Hemang Shah on 7/17/17.
//  Copyright © 2017 Hemang Shah. All rights reserved.
//

/*
 Idea of custom positions of title and image.
 Credits: https://gist.github.com/gbitaudeau/6540847de8f5ee9f2e0393a00d2cb11e
*/

import UIKit

///This is to show tabs inside the HHTabBarView. As it's subclassed of UIButton you can configure it as much as iOS supports.
public class HHTabButton: UIButton {
    
    ///Vertical Alignments
    public enum VerticalAlignment: String {
        case center, top, bottom, unset
    }
    
    ///Horizontal Alignments
    public enum HorizontalAlignment: String {
        case center, left, right, unset
    }

    ///Spacing between then image and title.
    public var imageToTitleSpacing: CGFloat = 8.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    ///Vertical alignment for the image.
    public var imageVerticalAlignment: VerticalAlignment = .unset {
        didSet {
            setNeedsLayout()
        }
    }
    
    ///Horizontal alignment for the image.
    public var imageHorizontalAlignment: HorizontalAlignment = .unset {
        didSet {
            setNeedsLayout()
        }
    }
    
    ///Set extra content edgeInsets.
    public var extraContentEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    override public var contentEdgeInsets: UIEdgeInsets {
        get {
            return super.contentEdgeInsets
        }
        set {
            super.contentEdgeInsets = newValue
            self.extraContentEdgeInsets = newValue
        }
    }
    
    ///Set extra image edgeInsets.
    public var extraImageEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    override public var imageEdgeInsets: UIEdgeInsets {
        get {
            return super.imageEdgeInsets
        }
        set {
            super.imageEdgeInsets = newValue
            self.extraImageEdgeInsets = newValue
        }
    }
    
    ///Set extra title edgeInsets.
    public var extraTitleEdgeInsets:UIEdgeInsets = UIEdgeInsets.zero
    
    override public var titleEdgeInsets: UIEdgeInsets {
        get {
            return super.titleEdgeInsets
        }
        set {
            super.titleEdgeInsets = newValue
            self.extraTitleEdgeInsets = newValue
        }
    }
    
    ///Unique index of tabs. (Should be start with 0)
    public var tabIndex:Int = 0
    
    ///To set badge value.
    internal var badgeValue: Int = 0 {
        willSet {
            self.addBadgeView()
        } didSet {
            self.updateBadgeView()
        }
    }

    ///Configure badge Label. Should be configure only after setting tabs array to HHTabBarView.
    public var badgeLabel: HHTabLabel?
    
    // MARK:Init
    required convenience public init(withTitle tabTitle: String?, tabImage: UIImage?, index: Int) {
        self.init(frame: CGRect.zero)
        self.setupButton(withTitle: tabTitle, tabImage: tabImage, index: index)
    }
    
    fileprivate func setupButton(withTitle tabTitle: String?, tabImage: UIImage?, index: Int) {
        self.backgroundColor = UIColor.clear
        self.autoresizingMask = [.flexibleWidth, .flexibleLeftMargin, .flexibleRightMargin, .flexibleHeight]
        self.tabIndex = index
        self.setImage(tabImage, for: .normal)
        self.setImage(tabImage, for: .selected)
        self.setTitle(tabTitle, for: .normal)
        self.setTitle(tabTitle, for: .selected)
    }
    
    //This is to add BadgeView within the HHTabButton. See badgeValue var to understand the usage.
    fileprivate func addBadgeView() {
        
        //If badge label is already created, no need to recreate.
        guard self.badgeLabel == nil else {
            return
        }
        
        let badgeSize: CGFloat = 20.0
        let margin: CGFloat = 3.0
        self.badgeLabel = HHTabLabel.init(frame: CGRect.init(x: self.frame.size.width - (badgeSize + margin), y: margin, width: badgeSize, height: badgeSize))
        self.badgeLabel!.isHidden = true //By default.
        self.addSubview(self.badgeLabel!)
    }
    
    //This is to update BadgeView within the HHTabButton. See badgeValue var to understand the usage.
    fileprivate func updateBadgeView() {
        if let label = self.badgeLabel {
            if self.badgeValue <= 0 {
                label.isHidden = true
                label.text = ""
            } else {
                label.isHidden = false
                label.text = String(self.badgeValue)
            }
        }
    }
    
    // MARK: Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LayoutSubviews
    override public func layoutSubviews() {
        if let imageSize = self.imageView?.image?.size,
            let font = self.titleLabel?.font,
            let textSize = self.titleLabel?.attributedText?.size() ?? self.titleLabel?.text?.size(withAttributes: [NSAttributedString.Key.font: font]) {
            
            var _imageEdgeInsets = UIEdgeInsets.zero
            var _titleEdgeInsets = UIEdgeInsets.zero
            var _contentEdgeInsets = UIEdgeInsets.zero
            
            let halfImageToTitleSpacing = imageToTitleSpacing / 2.0
            
            switch imageVerticalAlignment {
            case .bottom:
                _imageEdgeInsets.top = (textSize.height + imageToTitleSpacing) / 2.0
                _imageEdgeInsets.bottom = (-textSize.height - imageToTitleSpacing) / 2.0
                _titleEdgeInsets.top = (-imageSize.height - imageToTitleSpacing) / 2.0
                _titleEdgeInsets.bottom = (imageSize.height + imageToTitleSpacing) / 2.0
                _contentEdgeInsets.top = (min (imageSize.height, textSize.height) + imageToTitleSpacing) / 2.0
                _contentEdgeInsets.bottom = (min (imageSize.height, textSize.height) + imageToTitleSpacing) / 2.0
                //only works with contentVerticalAlignment = .center
                contentVerticalAlignment = .center
            case .top:
                _imageEdgeInsets.top = (-textSize.height - imageToTitleSpacing) / 2.0
                _imageEdgeInsets.bottom = (textSize.height + imageToTitleSpacing) / 2.0
                _titleEdgeInsets.top = (imageSize.height + imageToTitleSpacing) / 2.0
                _titleEdgeInsets.bottom = (-imageSize.height - imageToTitleSpacing) / 2.0
                _contentEdgeInsets.top = (min (imageSize.height, textSize.height) + imageToTitleSpacing) / 2.0
                _contentEdgeInsets.bottom = (min (imageSize.height, textSize.height) + imageToTitleSpacing) / 2.0
                //only works with contentVerticalAlignment = .center
                contentVerticalAlignment = .center
            case .center:
                //only works with contentVerticalAlignment = .center
                contentVerticalAlignment = .center
                break
            case .unset:
                break
            }
            
            switch imageHorizontalAlignment {
            case .left:
                _imageEdgeInsets.left = -halfImageToTitleSpacing
                _imageEdgeInsets.right = halfImageToTitleSpacing
                _titleEdgeInsets.left = halfImageToTitleSpacing
                _titleEdgeInsets.right = -halfImageToTitleSpacing
                _contentEdgeInsets.left = halfImageToTitleSpacing
                _contentEdgeInsets.right = halfImageToTitleSpacing
            case .right:
                _imageEdgeInsets.left = textSize.width + halfImageToTitleSpacing
                _imageEdgeInsets.right = -textSize.width - halfImageToTitleSpacing
                _titleEdgeInsets.left = -imageSize.width - halfImageToTitleSpacing
                _titleEdgeInsets.right = imageSize.width + halfImageToTitleSpacing
                _contentEdgeInsets.left = halfImageToTitleSpacing
                _contentEdgeInsets.right = halfImageToTitleSpacing
            case .center:
                _imageEdgeInsets.left = textSize.width / 2.0
                _imageEdgeInsets.right = -textSize.width / 2.0
                _titleEdgeInsets.left = -imageSize.width / 2.0
                _titleEdgeInsets.right = imageSize.width / 2.0
                _contentEdgeInsets.left = -((imageSize.width + textSize.width) - max (imageSize.width, textSize.width)) / 2.0
                _contentEdgeInsets.right = -((imageSize.width + textSize.width) - max (imageSize.width, textSize.width)) / 2.0
            case .unset:
                break
            }
            
            _contentEdgeInsets.top += extraContentEdgeInsets.top
            _contentEdgeInsets.bottom += extraContentEdgeInsets.bottom
            _contentEdgeInsets.left += extraContentEdgeInsets.left
            _contentEdgeInsets.right += extraContentEdgeInsets.right
            
            _imageEdgeInsets.top += extraImageEdgeInsets.top
            _imageEdgeInsets.bottom += extraImageEdgeInsets.bottom
            _imageEdgeInsets.left += extraImageEdgeInsets.left
            _imageEdgeInsets.right += extraImageEdgeInsets.right
            
            _titleEdgeInsets.top += extraTitleEdgeInsets.top
            _titleEdgeInsets.bottom += extraTitleEdgeInsets.bottom
            _titleEdgeInsets.left += extraTitleEdgeInsets.left
            _titleEdgeInsets.right += extraTitleEdgeInsets.right
            
            super.imageEdgeInsets = _imageEdgeInsets
            super.titleEdgeInsets = _titleEdgeInsets
            super.contentEdgeInsets = _contentEdgeInsets
            
        } else {
            super.imageEdgeInsets = extraImageEdgeInsets
            super.titleEdgeInsets = extraTitleEdgeInsets
            super.contentEdgeInsets = extraContentEdgeInsets
        }
        
        super.layoutSubviews()
    }
}
