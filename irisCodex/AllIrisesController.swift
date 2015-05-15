//
//  BeardlessController.swift
//  irisCodex
//
//  Created by manatee on 5/5/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift

class AllIrisesController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UISearchControllerDelegate {

  @IBOutlet weak var beardlessIrisTable: UITableView!
  @IBAction func toggleMenu(sender: AnyObject) {
    toggleSideMenuView()
  }
  
  @IBOutlet weak var irisCount: UILabel!
  
  // get all Irises
  let irises = Realm().objects(Iris)
  
  
  override func viewDidLoad() {
      super.viewDidLoad()
      // irisCount.text = "hello"
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    //self.beardlessIrisTable.reloadData()
  }
  
  // ***** setup the table and cells
  // setup the tableView sections and cells
  func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1}
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return irises.count }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) as! UITableViewCell
    let iris = irises[indexPath.row]
    cell.textLabel?.text = iris.name
    cell.detailTextLabel?.text = "\(iris.hybridizer) - \(iris.category)"
    return cell
  }
  
  //setup what action happens when selecting individual cell
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let iris = irises[indexPath.row]
    println(iris)
  }
  
  
  // ***** Search methods *****


}
