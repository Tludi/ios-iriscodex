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
  @IBAction func toggleMenu(sender: AnyObject) {
    toggleSideMenuView()
  }
  
  // get all Irises
  //let irises = Realm().objects(Iris)
  let allIrises = Realm().objects(Iris)
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    //do_table_refresh()
    
  }
  
  override func viewDidLoad() {
      super.viewDidLoad()
      checkForData()
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    //self.beardlessIrisTable.reloadData()
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
    return cell
  }
  
  //setup what action happens when selecting individual cell
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let iris = allIrises[indexPath.row]
    println(iris)
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
  
  func checkForData() {
    if allIrises.count == 0 {
      
      DataManager.getIrisDataFromFileWithSuccess {
        (data) -> Void in
        println("got data")
        let json = JSON(data: data)
        
        
        if let irisArray = json["iris"].array {
          println("ok so far")
          var irisesFromJSON = [Irises]()
          
          for irisDictionary in irisArray {
            var irisId: String? = NSUUID().UUIDString
            var irisName: String? = irisDictionary["Name"].string
            var irisHybridizer: String? = irisDictionary["Hybridizer"].string
            var irisCategory: String? = irisDictionary["Category"].string
            var irisGardenOne: Bool? = irisDictionary["1"].bool
            var irisGardenTwo: Bool? = irisDictionary["2"].bool
            var irisGardenThree: Bool? = irisDictionary["3"].bool
            var irisGardenFour: Bool? = irisDictionary["4"].bool
            var irisGardenFive: Bool? = irisDictionary["5"].bool
            var irisGardenSix: Bool? = irisDictionary["6"].bool
            var irisRegion13: Bool? = irisDictionary["R13"].bool
            var irisIrisType: String? = irisDictionary["Type"].string
            var irisYear: String? = irisDictionary["Year"].string
            var irisNote: String? = "Notes:"
            var irisFavorite: Bool? = false
            
            var newIris = Irises(id: irisId!, name: irisName!, hybridizer: irisHybridizer!, category: irisCategory!, gardenOne: irisGardenOne!, gardenTwo: irisGardenTwo!, gardenThree: irisGardenThree!, gardenFour: irisGardenFour!, gardenFive: irisGardenFive!, gardenSix: irisGardenSix!, region13: irisRegion13!, irisType: irisIrisType!, year: irisYear!, note: irisNote!, favorite: irisFavorite!)
            irisesFromJSON.append(newIris)
            
          } // end for irisDictionary
          println("name: \(irisesFromJSON[0].name) Hybridizer: \(irisesFromJSON[0].hybridizer)")
          
          let realm = Realm()
          let irises = realm.objects(Iris)
          
          for i in 0 ..< irisesFromJSON.count {
            println(irisesFromJSON[i].name)
            
            var newIrisId = irisesFromJSON[i].id
            var newIrisName = irisesFromJSON[i].name.lowercaseString.capitalizedString
            var newIrisHybridizer = irisesFromJSON[i].hybridizer
            var newIrisCategory = irisesFromJSON[i].category
            var newIrisGardenOne = irisesFromJSON[i].gardenOne
            var newIrisGardenTwo = irisesFromJSON[i].gardenTwo
            var newIrisGardenThree = irisesFromJSON[i].gardenThree
            var newIrisGardenFour = irisesFromJSON[i].gardenFour
            var newIrisGardenFive = irisesFromJSON[i].gardenFive
            var newIrisGardenSix = irisesFromJSON[i].gardenSix
            var newirisRegion13 = irisesFromJSON[i].region13
            var newIrisIrisType = irisesFromJSON[i].irisType
            var newIrisYear = irisesFromJSON[i].year
            var newIrisNote = irisesFromJSON[i].note
            var newIrisFavorite = irisesFromJSON[i].favorite
            
            realm.write {
              realm.create(Iris.self, value: [newIrisId, newIrisName, newIrisHybridizer, newIrisCategory,  newIrisGardenOne, newIrisGardenTwo, newIrisGardenThree, newIrisGardenFour, newIrisGardenFive, newIrisGardenSix, newirisRegion13, newIrisIrisType, newIrisYear, newIrisNote, newIrisFavorite])
              
            } // end realm.write
            self.do_table_refresh()
          }
          
        } // end if let irisArray
      } // end DataManager
      //do_table_refresh()
    }
  }
  
  func do_table_refresh()
  {
    dispatch_async(dispatch_get_main_queue(), {
      self.allIrisesTable.reloadData()
      return
    })
  }
  // ***** Search methods *****


}
