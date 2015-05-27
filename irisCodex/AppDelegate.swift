//
//  AppDelegate.swift
//  irisCodex
//
//  Created by manatee on 5/5/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  let allIrises = Realm().objects(Iris)

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)

    let irises = allIrises
    println("number of Irises in Base Realm - \(irises.count)")
    
    // populate realm if empty
    if irises.count == -1 {
      
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
          }
          
        } // end if let irisArray
      } // end DataManager
      
      
        
//        realm.write {
//          realm.create(Iris.self, value: ["yellow rose", "smith", "Bearded", true, true, true, true, true, true, false, "SIB", "2012"])
//          realm.create(Iris.self, value: ["peach blossom", "anderson", "Beardless", true, true, true, true, true, true, false, "PCI", "2000"])

      
    } // end check for empty Iris database
  
    return true // default return type
  } // end didFinishLaunchingWithOptions

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    //self.saveContext()
  }

//  // MARK: - Core Data stack
//
//  lazy var applicationDocumentsDirectory: NSURL = {
//      // The directory the application uses to store the Core Data store file. This code uses a directory named "com.diligentagility.irisCodex" in the application's documents Application Support directory.
//      let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
//      return urls[urls.count-1] as! NSURL
//  }()
//
//  lazy var managedObjectModel: NSManagedObjectModel = {
//      // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
//      let modelURL = NSBundle.mainBundle().URLForResource("irisCodex", withExtension: "momd")!
//      return NSManagedObjectModel(contentsOfURL: modelURL)!
//  }()
//
//  lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
//      // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
//      // Create the coordinator and store
//      var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
//      let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("irisCodex.sqlite")
//      var error: NSError? = nil
//      var failureReason = "There was an error creating or loading the application's saved data."
//      if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
//          coordinator = nil
//          // Report any error we got.
//          var dict = [String: AnyObject]()
//          dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
//          dict[NSLocalizedFailureReasonErrorKey] = failureReason
//          dict[NSUnderlyingErrorKey] = error
//          error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
//          // Replace this with code to handle the error appropriately.
//          // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//          NSLog("Unresolved error \(error), \(error!.userInfo)")
//          abort()
//      }
//      
//      return coordinator
//  }()
//
//  lazy var managedObjectContext: NSManagedObjectContext? = {
//      // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
//      let coordinator = self.persistentStoreCoordinator
//      if coordinator == nil {
//          return nil
//      }
//      var managedObjectContext = NSManagedObjectContext()
//      managedObjectContext.persistentStoreCoordinator = coordinator
//      return managedObjectContext
//  }()
//
//  // MARK: - Core Data Saving support
//
//  func saveContext () {
//      if let moc = self.managedObjectContext {
//          var error: NSError? = nil
//          if moc.hasChanges && !moc.save(&error) {
//              // Replace this implementation with code to handle the error appropriately.
//              // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//              NSLog("Unresolved error \(error), \(error!.userInfo)")
//              abort()
//          }
//      }
//  }

}

