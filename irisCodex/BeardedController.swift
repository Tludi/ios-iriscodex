//
//  BeardedController.swift
//  irisCodex
//
//  Created by manatee on 5/5/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift


class BeardedController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var beardedIrisTable: UITableView!
  // toggle the side menu with the navigation button
  @IBAction func toggleMenu(sender: AnyObject) { toggleSideMenuView() }
  @IBAction func addIrisButton(sender: AnyObject) {
  addNewItem()
  }
  
  @IBAction func clearDatabase(sender: AnyObject) {
    clearDatabase()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // let irises = Realm().objects(Iris)
    
    if self.title == nil {
      self.title = "Bearded"
    }
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
//    println(self.title!)
    self.beardedIrisTable.reloadData()
  }
  
  // setup the tableView sections and cells
  func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1}
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let irises = Realm().objects(Iris).filter("category = '\(self.title!)'")
    return irises.count
  }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
    if self.title == "IrisCodex" {
      //let irises = Realm().objects(Iris)
      println(self.title)
    }
      let irises = Realm().objects(Iris).filter("category = '\(self.title!)'")
    let iris = irises[indexPath.row]
    cell.textLabel?.text = iris.name
    cell.detailTextLabel?.text = "\(iris.hybridizer) - \(iris.category)"
    return cell
  }
  
  //setup what action happens when selecting individual cell
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let irises = Realm().objects(Iris).filter("category = '\(self.title!)'")
    let iris = irises[indexPath.row]
//    println(iris)
  }
  
//  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//    return true
//  }
  
//  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//    if(editingStyle == .Delete) {
//      let realm = Realm()
//      let irisToDelete = irises[indexPath.row]
//      realm.write {
//        realm.delete(irisToDelete)
//      }
//      beardedIrisTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//    }
//  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "irisDetail" {
      if let destinationController = segue.destinationViewController as? irisDetailController {
        if let irisIndex = beardedIrisTable.indexPathForSelectedRow() {
          let irises = Realm().objects(Iris).filter("category = '\(self.title!)'")
          let iris = irises[irisIndex.row]
          destinationController.singleIris = iris
        }
      }
    }
  }
  
  
  
  // let addItemAlertViewTag = 0
  // let addItemTextAlertViewTag = 1
  func addNewItem() {
    var irisPrompt = UIAlertController(title: "New Iris", message: "Enter Text", preferredStyle: .Alert)
    var nameTextField: UITextField?
    var hybridizerTextField: UITextField?
    irisPrompt.addTextFieldWithConfigurationHandler {
      (nameField) -> Void in
      nameTextField = nameField
      nameField.placeholder = "Name"
    }
    irisPrompt.addTextFieldWithConfigurationHandler {
      (hybridizerField) -> Void in
      hybridizerTextField = hybridizerField
      hybridizerField.placeholder = "Hybridizer"
    }
    
    irisPrompt.addAction(UIAlertAction(title: "OK",
      style: .Default,
      handler: {(action) -> Void in
      if let nameField = nameTextField  {
        self.saveNewIris(nameField.text, hybridizer: hybridizerTextField!.text)
      }
    }))
    
    self.presentViewController(irisPrompt, animated: true, completion: nil)
  }
  
  func saveNewIris(name: String, hybridizer: String) {
    let realm = Realm()
    let iris = Iris()
    iris.name = name
    iris.hybridizer = hybridizer
    realm.write {
      realm.add(iris)
    }
    self.beardedIrisTable.reloadData()
    //self.beardedIrisTable.reloadRowsAtIndexPaths(index, withRowAnimation: UITableViewRowAnimation.Automatic )
  }
  
  func clearDatabase() {
    let realm = Realm()
    let iris = Iris()
    realm.write {
      realm.deleteAll()
    }
    self.beardedIrisTable.reloadData()
    //self.beardedIrisTable.reloadRowsAtIndexPaths(index, withRowAnimation: UITableViewRowAnimation.Automatic )
  }
  

  
}



