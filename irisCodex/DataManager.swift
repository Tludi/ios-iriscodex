//
//  DataManager.swift
//  irisCodex
//
//  Created by manatee on 5/5/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import Foundation
import RealmSwift


class DataManager {
  // get data from allIrises.json file
  class func getIrisDataFromFileWithSuccess(success: ((data: NSData) -> Void)) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
      let filePath = NSBundle.mainBundle().pathForResource("allIrises",ofType:"json")
      var readError:NSError?
      if let data = NSData(contentsOfFile:filePath!,
        options: NSDataReadingOptions.DataReadingUncached,
        error:&readError) {
        success(data: data)
      }
    })
  }
  
  // populate Database (uses Realm.io)
  class func populateRealm(tableView: UITableView, spinner: UIActivityIndicatorView, menuButton: UIBarButtonItem, blurView: UIVisualEffectView) ->  Void {
    let irises = Realm().objects(Iris)
    
    self.getIrisDataFromFileWithSuccess {
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
          var irisNote: String? = ""
          var irisFavorite: Bool? = false
          
          var newIris = Irises(id: irisId!, name: irisName!, hybridizer: irisHybridizer!, category: irisCategory!, gardenOne: irisGardenOne!, gardenTwo: irisGardenTwo!, gardenThree: irisGardenThree!, gardenFour: irisGardenFour!, gardenFive: irisGardenFive!, gardenSix: irisGardenSix!, region13: irisRegion13!, irisType: irisIrisType!, year: irisYear!, note: irisNote!, favorite: irisFavorite!)
          irisesFromJSON.append(newIris)
          
        } // end for irisDictionary
        
        //println("name: \(irisesFromJSON[0].name) Hybridizer: \(irisesFromJSON[0].hybridizer)")
        //println("JSON irises count - \(irisesFromJSON.count)")
        let realm = Realm()
        let irises = realm.objects(Iris)
        
        for i in 0 ..< irisesFromJSON.count {
          println("\(irisesFromJSON[i].name) - \(i)")
          
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
          
          // check to see if all irises have been added then reload view
          if i == irisesFromJSON.count - 1 {
            dispatch_async(dispatch_get_main_queue(), {
              tableView.reloadData()
              spinner.stopAnimating()
              menuButton.enabled = true
              blurView.hidden = true
              return
            })
          }
        }
        
      } // end if let irisArray
    } // end getIrisData
  } // end populate Realm
  
}