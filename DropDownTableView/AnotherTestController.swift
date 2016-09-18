//
//  TestViewController.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 26.12.15.
//  Copyright © 2015 NSSimpleApps. All rights reserved.
//

import UIKit

class AnotherTestController: DropDownTableViewController {
    
    fileprivate var numberOfSubrows = 5
    fileprivate var numberOfRows = 50
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "Another test"
        
        self.navigationItem.rightBarButtonItems =
        [UIBarButtonItem(title: "Insert", style: .plain, target: self, action: #selector(self.insertRows(_:))),
        UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(self.deleteRows(_:)))]
    }
    
    func insertRows(_ sender: UIBarButtonItem) {
        
        self.numberOfRows += 2
        
        self.tableView.insertRowsAtRows([0, 1], withRowAnimation: .automatic)
    }
    
    func deleteRows(_ sender: UIBarButtonItem) {
        
        self.numberOfRows -= 2
        
        self.tableView.deleteRowsAtRows([0, 1], withRowAnimation: .automatic)
    }
    
    override func numberOfRowsInTableView(_ tableView: UITableView) -> Int {
        
        return self.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int {
        
        return self.numberOfSubrows
    }
    
    override func tableView(_ tableView: UITableView, cellForRow row: Int, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Row " + String(row)
        cell.detailTextLabel?.text = nil
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, cellForSubrow subrow: Int, inRow row: Int, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Subrow " + String(row)
        cell.detailTextLabel?.text = String(subrow)
        cell.accessoryView = nil
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryViewForSelectedRow row: Int) -> UIView? {
        
        return UIImageView(image: UIImage(named: "selectedImage"))
    }
    
    override func tableView(_ tableView: UITableView, accessoryViewForDeselectedRow row: Int) -> UIView? {
        
        return UIImageView(image: UIImage(named: "deselectedImage"))
    }
}
