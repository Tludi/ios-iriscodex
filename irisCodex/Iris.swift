//
//  Iris.swift
//  irisCodex
//
//  Created by manatee on 5/6/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import Foundation
import RealmSwift

class Iris: Object {
  dynamic var id = ""
  dynamic var name = ""
  dynamic var hybridizer = ""
  dynamic var category = ""
  dynamic var garden1 = true
  dynamic var garden2 = true
  dynamic var garden3 = true
  dynamic var garden4 = true
  dynamic var garden5 = true
  dynamic var garden6 = true
  dynamic var region13 = true
  dynamic var irisType = ""
  dynamic var year = ""
  dynamic var note = ""
  dynamic var favorite = false
  
  
  override static func primaryKey() -> String? {
    return "id"
  }
}


