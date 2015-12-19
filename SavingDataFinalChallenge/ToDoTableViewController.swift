//
//  ToDoTableViewController.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 12/19/15.
//  Copyright © 2015 nmg82. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
  private var items = [Item]()
  private let persistentStore = NSDataStore()
  
  override func viewWillAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    items = persistentStore.getItems()
    
    tableView.reloadData()
    
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath)
    
    cell.textLabel?.text = items[indexPath.row].name
    
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let itemViewController = storyboard?.instantiateViewControllerWithIdentifier("itemViewController") as! ItemViewController
    itemViewController.itemToEdit = items[indexPath.row]
    
    navigationController?.pushViewController(itemViewController, animated: true)
  }
  
}
