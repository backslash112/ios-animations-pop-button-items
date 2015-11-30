//
//  YCPopupMenu.swift
//  ios-animations-pop-button-items
//
//  Created by Carl.Yang on 11/30/15.
//  Copyright © 2015 Yangcun. All rights reserved.
//

import UIKit
import pop

protocol YCPopupMenuDelegate {
    func popupMenu(menu: YCPopupMenu, didClickedAtIndex index: Int)
}

class YCPopupMenu: UIControl {

    var delegate: YCPopupMenuDelegate?
    var icons: Array<UIImage>!
    var iconViews: Array<UIButton>!
    var targetButton: UIButton!
    var iconDistance: Double = 40
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(frame: CGRect, target: UIButton, iconArray: Array<UIImage>) {
        super.init(frame: frame)
        self.icons = iconArray
        self.targetButton = target
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAction() {
        for icon in self.iconViews {
            icon.addTarget(self, action: "click:", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    func click(sender: UIButton) {
        let index = self.iconViews.indexOf(sender)
        self.delegate?.popupMenu(self, didClickedAtIndex: index!)
    }
    
    func presentSubMenu() {
        
        var iconNumber: Double = 1
        iconViews = []
        for iconImage in self.icons {
            let iconView = UIButton()
            iconView.setBackgroundImage(iconImage, forState: UIControlState.Normal)
            iconView.sizeToFit()
            iconView.tag = 1000 + Int(iconNumber)
            iconView.center = CGPointMake(targetButton.center.x - CGFloat(iconDistance * iconNumber), targetButton.center.y + CGFloat(iconDistance * iconNumber))
            iconView.alpha = 0.0
            self.addSubview(iconView)
            iconViews.append(iconView)
            iconNumber++
        }
        iconNumber = 1
        for icon in iconViews {
            let alpha = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            alpha.toValue = 1.0
            alpha.duration = 0.2
            alpha.beginTime = CACurrentMediaTime() + iconNumber * 0.06
            icon.pop_addAnimation(alpha, forKey: "alpha")
            iconNumber++
        }
        self.setupAction()
    }
    
    func dismiss() {
        for view in self.subviews {
            if view.tag > 1000 {
                view.removeFromSuperview()
            }
        }
    }
    
    func hide() {
        self.dismiss()
    }
}
