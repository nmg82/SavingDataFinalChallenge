//
//  PersistentStoreFactory.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 12/21/15.
//  Copyright © 2015 nmg82. All rights reserved.
//

import Foundation

class PersistentStoreFactory {
  class func getPersistentStore() -> PersistentStore {
    let defaults = NSUserDefaults.standardUserDefaults()
    let selectedType = defaults.integerForKey("persistentStoreType")
    
    switch selectedType {
    case 0:
      return StringStore()
    case 1:
      return NSCodingStore()
    case 2:
      return PropertyListStore()
    case 3:
      return XmlStore()
    case 4:
      return JsonStore()
    case 5:
      return SqliteStore()
    case 6:
      return FmdbStore()
    default:
      return NSCodingStore()
    }
  }
}