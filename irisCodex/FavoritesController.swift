//
//  FavoritesController.swift
//  irisCodex
//
//  Created by Timothy Ludi on 5/22/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift

class FavoritesController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  let irises = Realm().objects(Iris).filter("favorite = true")
  
  @IBOutlet weak var favoriteTable: UITableView!
  @IBAction func toggleMenu(sender: AnyObject) {
    toggleSideMenuView()
  }
  @IBOutlet weak var addFavoriteView: UIView!
  
  override func viewWillAppear(animated: Bool) {
    checkForNoFavoritesView()
    self.favoriteTable.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    checkForNoFavoritesView()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return irises.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("Cell3", forIndexPath: indexPath) as! UITableViewCell
    let iris = irises[indexPath.row]
    cell.textLabel?.text = iris.name
    cell.detailTextLabel?.text = "\(iris.hybridizer) - \(iris.category)"
    
    return cell
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "favoriteSegue" {
      if let destinationController = segue.destinationViewController as? irisDetailController {
        if let irisIndex = favoriteTable.indexPathForSelectedRow() {
          let irises = Realm().objects(Iris).filter("favorite = true")
          let iris = irises[irisIndex.row]
          destinationController.singleIris = iris
        }
      }
    }
  }
  
  func checkForNoFavoritesView() {
    if irises.count == 0 {
      addFavoriteView.hidden = false
      addFavoriteView.layer.cornerRadius = 10.0
    }
  }


}
