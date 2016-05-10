//
//  ViewController.swift
//  ActionSheetSwift
//
//  Created by AsianTech on 3/24/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let sheetView = ActionSheetView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addActionSheetView()
    }
    
    func addActionSheetView() {
        let subView = self.createDatePicker()
        self.sheetView.addView(subView, title: "Sheet", delegate: self, tag: 1, supperView: self.view)
        self.sheetView.showActionSheet()
    }
    
    func createDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.maximumDate = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let startDate = formatter.dateFromString("1/1/1990")
        datePicker.date = startDate!
        datePicker.locale = NSLocale(localeIdentifier: "en_GB")
        return datePicker
    }
//    _datePiker = [UIDatePicker autoLayoutView];
//    _datePiker.datePickerMode = UIDatePickerModeDate;
//    [_datePiker setMaximumDate:[NSDate date]];
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    formatter.dateFormat = @"dd/MM/yyyy";
//    NSDate *startDate = [formatter dateFromString:@"1/1/1990"];
//    _datePiker.date = startDate;
//    _datePiker.locale =  [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
}

