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
  
  override func viewWillAppear(animated: Bool) {
    self.favoriteTable.reloadData()
  }
  
  
  override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
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
    //let irises = Realm().objects(Iris)//.filter("favorite = true")
    let iris = irises[indexPath.row]
    cell.textLabel?.text = iris.name
    cell.detailTextLabel?.text = "\(iris.hybridizer) - \(iris.category)"
    //cell.imageView?.image = UIImage(named: "star2@1x.png")
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
