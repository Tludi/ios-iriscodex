//
//  MenuTableViewController.swift
//  irisCodex
//
//  Created by manatee on 5/5/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift

class MenuTableViewController: UITableViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
    
      tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
      // Uncomment the following line to preserve selection between presentations
      // self.clearsSelectionOnViewWillAppear = false

  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }

  override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
    header.contentView.backgroundColor = UIColor.whiteColor()
    
    header.textLabel.textColor = UIColor.darkGrayColor()
    header.alpha = 0.3
    header.textLabel.textAlignment = NSTextAlignment.Center
  }
  
  override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 30.0
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Iris Codex"
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var destinationViewController: UIViewController!
    var selectedCell = tableView.cellForRowAtIndexPath(indexPath)!
    selectedCell.contentView.backgroundColor = UIColor.blueColor()
    
    switch (indexPath.row) {
    case 0:
      destinationViewController = storyboard.instantiateViewControllerWithIdentifier("AllIrisesController") as! AllIrisesController
      destinationViewController.title = "All Irises"
      break
    case 1:
      destinationViewController = storyboard.instantiateViewControllerWithIdentifier("BeardedController") as! BeardedController
      destinationViewController.title = "Bearded"
      break
    case 2:
      destinationViewController = storyboard.instantiateViewControllerWithIdentifier("BeardedController") as! BeardedController
      destinationViewController.title = "Beardless"
      break
    case 3:
      destinationViewController = storyboard.instantiateViewControllerWithIdentifier("FavoritesController") as! FavoritesController
      destinationViewController.title = "Favorites"
      break
    default:
      destinationViewController = storyboard.instantiateViewControllerWithIdentifier("AllIrisesController") as! AllIrisesController
      destinationViewController.title = "IrisCodex"
      break
    }
    
    sideMenuController()?.setContentViewController(destinationViewController)
  }

}
