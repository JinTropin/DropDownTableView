//
//  TestViewController.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 26.12.15.
//  Copyright © 2015 NSSimpleApps. All rights reserved.
//

import UIKit

private extension NSDate {
    
    var customDateFormat: String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "d MMM YYYY"
        
        return dateFormatter.stringFromDate(self)
    }
}

class TestViewController: DropDownTableViewController {
    
    private var value = 0
    private var date = NSDate()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.title = "Test"
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        self.value = userDefaults.integerForKey("value")
        
        if let date = userDefaults.objectForKey("date") as? NSDate {
            
            self.date = date
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setInteger(self.value, forKey: "value")
        userDefaults.setObject(self.date, forKey: "date")
    }
    
    override func numberOfRowsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRow row: Int, indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if row == 0 {
            
            cell.textLabel?.text = "Value"
            cell.detailTextLabel?.text = String(self.value)
            
        } else {
            
            cell.textLabel?.text = "Date"
            cell.detailTextLabel?.text = self.date.customDateFormat
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, cellForSubrow subrow: Int, row: Int, indexPath: NSIndexPath) -> UITableViewCell {
        
        if row == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("PickerCell", forIndexPath: indexPath)
            
            // this is dirty hack. Don't do it anymore
            if let pickerView = cell.contentView.subviews.first as? UIPickerView {
                
                pickerView.selectRow(self.value, inComponent: 0, animated: false)
            }
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("DateCell", forIndexPath: indexPath)
            
            // this is dirty hack. Don't do it anymore
            if let datePicker = cell.contentView.subviews.first as? UIDatePicker {
                
                datePicker.date = self.date
            }
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, accessoryViewForSelectedRow row: Int) -> UIView? {
        
        return UIImageView(image: UIImage(named: "selectedImage"))
    }
    
    override func tableView(tableView: UITableView, accessoryViewForDeselectedRow row: Int) -> UIView? {
        
        return UIImageView(image: UIImage(named: "deselectedImage"))
    }
    
    //func tableView(tableView: UITableView, heightForRow row: Int) -> CGFloat
    
    override func tableView(tableView: UITableView, heightForSubrow subrow: Int, row: Int) -> CGFloat {
        
        return 216
    }
    
    @IBAction func dateChanged(sender: UIDatePicker) {
        
        self.date = sender.date
        
        if let cell = self.cellForRow(1) {
            
            cell.detailTextLabel?.text = self.date.customDateFormat
        }
    }
}

extension TestViewController: UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return 10
    }
}

extension TestViewController: UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(row)
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.value = row
        
        if let cell = self.cellForRow(0) {
            
            cell.detailTextLabel?.text = String(self.value)
        }
    }
}


