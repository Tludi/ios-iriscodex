//
//  BeardedController.swift
//  irisCodex
//
//  Created by manatee on 5/5/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import CoreData


class BeardedController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var beardedIrisTable: UITableView!
  // toggle the side menu with the navigation button
  @IBAction func toggleMenu(sender: AnyObject) { toggleSideMenuView() }
  @IBAction func addIrisButton(sender: AnyObject) {
    addNewItem()
  }
  
  
  // access the core data context
  let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
  // create the irises array
  var irises = [Iris]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // put sample data into irises array if managedObjectContext exists
      if let moc = self.managedObjectContext {
        var irises = [
        ("Bearded", "Yellow Rose in twilight moon", "Aitken", "2012", true, true, true, true, true, true, "SIB", true),
        ("Beardless", "Bearded Lilly", "Ludi", "2000", true, false, true, false, true, false, "PCI", false)
        ]
        // loop through the irises array and put data in context
        if irises.count == 0 {
        for (category, name, hybridizer, year, garden1, garden2, garden3, garden4, garden5, garden6, irisType, region13) in irises {
          Iris.createInManagedObjectContext(moc, category: category, name: name, hybridizer: hybridizer, year: year, garden1: garden1, garden2: garden2, garden3: garden3, garden4: garden4, garden5: garden5, garden6: garden6, irisType: irisType, region13: region13)
        }  // end for loop
      }
      } // end if let moc
    fetchLog() // run the fetchlog function
  }
  
  func fetchLog() {
    let fetchRequest = NSFetchRequest(entityName: "Iris")
    // sort by name
    let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    // filter by category
    let predicate = NSPredicate(format: "category == %@", "Bearded")
    fetchRequest.predicate = predicate
    // assign fetchResults to irises array if fetchResults exists
    if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Iris] { irises = fetchResults }
  } // end fetchlog
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
  }
  
  // setup the tableView sections and cells
  func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1}
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return irises.count }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
    let iris = irises[indexPath.row]
    cell.textLabel?.text = iris.name
    cell.detailTextLabel?.text = iris.hybridizer
    return cell
  }
  // setup what action happens when selecting individual cell
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let iris = irises[indexPath.row]
    println(iris.name)
  }
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if(editingStyle == .Delete) {
      let irisToDelete = irises[indexPath.row]
      managedObjectContext?.deleteObject(irisToDelete)
      self.fetchLog()
      beardedIrisTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
      saveIris()
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
    var newIris = Iris.createInManagedObjectContext(self.managedObjectContext!, category: "Bearded", name: name, hybridizer: hybridizer, year: "2005", garden1: true, garden2: true, garden3: true, garden4: true, garden5: true, garden6: true, irisType: "SIB", region13: true)
    self.fetchLog()
    if let newIrisIndex = find(irises, newIris) {
      let newIrisIndexPath = NSIndexPath(forRow: newIrisIndex, inSection: 0)
      beardedIrisTable.insertRowsAtIndexPaths([newIrisIndexPath], withRowAnimation: .Automatic)
      saveIris()
    }
  }
  func saveIris() {
    var error: NSError?
    if(managedObjectContext!.save(&error)){
      println(error?.localizedDescription)
    }
  }
}

