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

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
  override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
    header.contentView.backgroundColor = UIColor.grayColor()
    header.textLabel.textColor = UIColor.whiteColor()
    header.alpha = 0.5
  }
  
  override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 30.0
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Menu"
  }
  
  
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var destinationViewController: UIViewController!
    var selectedCell = tableView.cellForRowAtIndexPath(indexPath)!
    selectedCell.contentView.backgroundColor = UIColor.blueColor()
    
    switch (indexPath.row) {
    case 0:
      
      destinationViewController = storyboard.instantiateViewControllerWithIdentifier("BeardedController") as! BeardedController
      destinationViewController.title = "Bearded"
      break
    case 1:
      destinationViewController = storyboard.instantiateViewControllerWithIdentifier("BeardedController") as! BeardedController
      destinationViewController.title = "Beardless"
      break
    case 2:
      destinationViewController = storyboard.instantiateViewControllerWithIdentifier("AllIrisesController") as! AllIrisesController
      destinationViewController.title = "Test"
      break
    default:
      destinationViewController = storyboard.instantiateViewControllerWithIdentifier("BeardedController") as! BeardedController
      destinationViewController.title = "IrisCodex"
      break
    }

//    if indexPath.row == 1 {
//      destinationViewController = storyboard.instantiateViewControllerWithIdentifier("BeardedController") as! BeardedController
//    } if else {
//      destinationViewController = storyboard.instantiateViewControllerWithIdentifier("BeardlessController") as! BeardlessController
//    }
    
    sideMenuController()?.setContentViewController(destinationViewController)
  }
  
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
