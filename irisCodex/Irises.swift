//
//  Irises.swift
//  irisCellTest
//
//  Created by manatee on 4/29/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import Foundation

class Irises
{
  var name = "name"
  var hybridizer = "hybridizer"
  var category = "category"
  var gardenOne = true
  var gardenTwo = true
  var gardenThree = true
  var gardenFour = true
  var gardenFive = true
  var gardenSix = true
  var region13 = true
  var irisType = "irisType"
  var year = "year"
  
  init(name: String?, hybridizer: String?, category: String?, gardenOne: Bool, gardenTwo: Bool, gardenThree: Bool, gardenFour: Bool, gardenFive: Bool, gardenSix: Bool, region13: Bool, irisType: String, year: String?)
  {
    self.name = name ?? ""
    self.hybridizer = hybridizer ?? ""
    self.category = category ?? ""
    self.gardenOne = gardenOne
    self.gardenTwo = gardenTwo
    self.gardenThree = gardenThree
    self.gardenFour = gardenFour
    self.gardenFive = gardenFive
    self.gardenSix = gardenSix
    self.region13 = region13
    self.irisType = irisType
    self.year = year ?? ""
  }
}