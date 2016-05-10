//
//  ActionSheetView.swift
//  ActionSheetSwift
//
//  Created by AsianTech on 3/24/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit

@objc protocol ActionSheetViewDelegate {
    optional func actionSheetCancel(sheet: ActionSheetView, tag: Int)
    optional func actionSheetDone(sheet: ActionSheetView, tag: Int)
}

class ActionSheetView: UIView {
    var contentView = UIView()
    var headerView = UIView()
    var bodyView = UIView()
    var pickerView = UIView()
    var headerTitle = UILabel()
    var cancelButton = UIButton()
    var doneButton = UIButton()
    var title: String?
    weak var delegate: ActionSheetViewDelegate?
    var tagView: Int?
    
    // MARK: - Public function
    
    func addView(view: UIView, title: String, delegate: AnyObject, tag: Int, supperView: UIView) {
        self.title = title
        self.pickerView = view
        self.delegate = delegate as? ActionSheetViewDelegate
        self.tagView = tag
        supperView.addSubview(self)
        supperView.allPin(self)
        self.setupContentView()
        self.setupHeaderView()
        self.setupBodyView()
        let button = UIButton()
        button.setTitle("Button", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.addSubview(button)
        self.addPin(button, attribute: .Top, toView: self, constant: 40)
        self.addHeightConstraint(button, constant: 40)
        self.addWidthConstraint(button, constant: 70)
        self.addPin(self, attribute: .CenterX, toView: button, constant: 0)
        button.addTarget(self, action: "show", forControlEvents: UIControlEvents.TouchUpInside)
        self.layoutIfNeeded()
    }

    func showActionSheet() {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.3 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.show()
        }
    }
    
    func setupContentView() {
        self.addSubview(self.contentView)
        self.addHeightConstraint(self.contentView, constant: 260)
        self.addPin(self, attribute: .Left, toView: self.contentView, constant: 0)
        self.addPin(self, attribute: .Right, toView: self.contentView, constant: 0)
        self.addPin(self, attribute: .Bottom, toView: self.contentView, constant: -260)
        self.contentView.layoutIfNeeded()
    }
    
    func setupHeaderView() {
        self.contentView.addSubview(self.headerView)
        self.addHeightConstraint(self.headerView, constant: 44)
        self.addPin(self.headerView, attribute: .Left, toView: self.contentView, constant: 0)
        self.addPin(self.headerView, attribute: .Right, toView: self.contentView, constant: 0)
        self.addPin(self.headerView, attribute: .Top, toView: self.contentView, constant: 0)
        self.headerView.backgroundColor = UIColor.grayColor()
        
        self.cancelButton.setTitle("Cancel", forState: UIControlState.Normal)
        self.cancelButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.headerView.addSubview(self.cancelButton)
        self.addHeightConstraint(self.cancelButton, constant: 30)
        self.addWidthConstraint(self.cancelButton, constant: 70)
        self.addPin(self.cancelButton, attribute: .CenterY, toView: self.headerView, constant: 0)
        self.addPin(self.cancelButton, attribute: .Left, toView: self.headerView, constant: 5)
        self.cancelButton.addTarget(self, action: "dismiss", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.doneButton.setTitle("Done", forState: UIControlState.Normal)
        self.doneButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.headerView .addSubview(self.doneButton)
        self.addHeightConstraint(self.doneButton, constant: 30)
        self.addWidthConstraint(self.doneButton, constant: 70)
        self.addPin(self.doneButton, attribute: .CenterY, toView: self.headerView, constant: 0)
        self.addPin(self.doneButton, attribute: .Right, toView: self.headerView, constant: 5)
        self.doneButton.addTarget(self, action: "dismiss", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.headerTitle.tintColor = UIColor.redColor()
        self.headerTitle.text = self.title!
        self.headerTitle.textAlignment = .Center
        self.headerView .addSubview(self.headerTitle)
        self.addHeightConstraint(self.headerTitle, constant: 30)
        self.addWidthConstraint(self.headerTitle, constant: 209)
        self.addPin(self.headerTitle, attribute: .CenterX, toView: self.headerView, constant: 0)
        self.addPin(self.headerTitle, attribute: .CenterY, toView: self.headerView, constant: 0)
        self.headerView.layoutIfNeeded()
    }
    
    func setupBodyView() {
        self.contentView .addSubview(self.pickerView)
        self.addPin(pickerView, attribute: .Left, toView: self.contentView, constant: 0)
        self.addPin(pickerView, attribute: .Right, toView: self.contentView, constant: 0)
        self.addPin(pickerView, attribute: .Bottom, toView: self.contentView, constant: 0)
        self.addConstraint(self.contentView, relation: .Equal, withItem: self.pickerView, withAttribute: .Top, toItem: self.headerView, toAttribute: .Bottom, constant: 0)
        self.contentView.layoutIfNeeded()
    }
    
    func show() {
        for  constraints in self.constraints {
            if constraints.firstAttribute == .Bottom && constraints.firstItem as! NSObject == self && constraints.secondAttribute == .Bottom && constraints.secondItem as! NSObject == self.contentView {
                print("show")
                constraints.constant = 0
            }
        }
        UIView.animateWithDuration(0.3) { () -> Void in
            self.layoutIfNeeded()
        }
    }
    
    func dismiss() {
        for  constraints in self.constraints {
            if constraints.firstAttribute == .Bottom && constraints.firstItem as! NSObject == self && constraints.secondAttribute == .Bottom && constraints.secondItem as! NSObject == self.contentView {
                print("show")
                constraints.constant = -260
            }
        }
        UIView.animateWithDuration(0.3) { () -> Void in
            self.layoutIfNeeded()
        }
    }
    
}
