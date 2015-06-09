//
//  AllIrisesController.swift
//  irisCodex
//
//  Created by manatee on 5/5/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift

class AllIrisesController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UISearchControllerDelegate {

  @IBOutlet weak var allIrisesTable: UITableView!
  @IBOutlet weak var menuButton: UIBarButtonItem!
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  @IBOutlet weak var codexLogo: UIImageView!
  @IBOutlet weak var blurView: UIVisualEffectView!
  @IBAction func toggleMenu(sender: AnyObject) {
    toggleSideMenuView()
  }
  // get all Irises
  let allIrises = Realm().objects(Iris)
  
  override func viewDidLoad() {
      super.viewDidLoad()
      checkForData()
  }

  override func viewWillAppear(animated: Bool) {
    self.allIrisesTable.reloadData()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  // ***** setup the table and cells
  // setup the tableView sections and cells
  func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1}
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return allIrises.count }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) as! UITableViewCell
    let iris = allIrises[indexPath.row]
    cell.textLabel?.text = iris.name
    cell.detailTextLabel?.text = "\(iris.hybridizer) - \(iris.category)"
    if (iris.favorite) {
      var imageName = "star2sm.png"
      var image = UIImage(named: imageName)
      cell.imageView?.image = image
    } else {
      cell.imageView?.image = UIImage(named: "star1sm.png")
    }
    return cell
  }
  
  //setup what action happens when selecting individual cell
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let iris = allIrises[indexPath.row]
    println(iris) // sends the selected iris row info to the console
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "allIrisDetail" {
      if let destinationController = segue.destinationViewController as? irisDetailController {
        if let irisIndex = allIrisesTable.indexPathForSelectedRow() {
          let irises = Realm().objects(Iris)
          let iris = irises[irisIndex.row]
          destinationController.singleIris = iris
        }
      }
    }
  }
  
  // initial population of database or if database is empty
  func checkForData() {
    //blurView.hidden = false
    if allIrises.count == 0 {
      blurView.hidden = false
      menuButton.enabled = false
      spinner.startAnimating()
      DataManager.populateRealm(allIrisesTable, spinner: spinner, menuButton: menuButton, blurView: blurView)
    }
  }
  
  // ***** Search methods *****
  // To be added as a future feature

}
