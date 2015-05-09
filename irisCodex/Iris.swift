//
//  Iris.swift
//  irisCodex
//
//  Created by manatee on 5/6/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import Foundation
import CoreData

class Iris: NSManagedObject {

    @NSManaged var category: String
    @NSManaged var garden1: Bool
    @NSManaged var garden2: Bool
    @NSManaged var garden3: Bool
    @NSManaged var garden4: Bool
    @NSManaged var garden5: Bool
    @NSManaged var garden6: Bool
    @NSManaged var hybridizer: String
    @NSManaged var name: String
    @NSManaged var region13: Bool
    @NSManaged var irisType: String
    @NSManaged var year: String

  class func createInManagedObjectContext(moc: NSManagedObjectContext, category: String, name: String, hybridizer: String, year: String, garden1: Bool, garden2: Bool, garden3: Bool, garden4: Bool, garden5: Bool, garden6: Bool, irisType: String, region13: Bool) -> Iris {
    let newItem = NSEntityDescription.insertNewObjectForEntityForName("Iris", inManagedObjectContext: moc) as! Iris
    
    newItem.category = category
    newItem.name = name
    newItem.hybridizer = hybridizer
    newItem.year = year
    newItem.garden1 = garden1
    newItem.garden2 = garden2
    newItem.garden3 = garden3
    newItem.garden4 = garden4
    newItem.garden5 = garden5
    newItem.garden6 = garden6
    newItem.irisType = irisType
    newItem.region13 = region13
    
    return newItem
  }
}
