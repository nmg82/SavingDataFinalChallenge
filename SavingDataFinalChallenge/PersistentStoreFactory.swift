//
//  PersistentStoreFactory.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 12/21/15.
//  Copyright © 2015 nmg82. All rights reserved.
//

import Foundation

class PersistentStoreFactory {
  class func getPersistentStore() -> PersistentStoreProtocol {
    let defaults = NSUserDefaults.standardUserDefaults()
    let selectedType = defaults.integerForKey("persistentStoreType")
    
    switch selectedType {
    case 0:
      return NSDataStore()
    case 1:
      return NSCodingStore()
    case 2:
      return PropertyListStore()
    default:
      return NSCodingStore()
    }
  }
}