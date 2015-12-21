//
//  NSCodingDataStore.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 12/19/15.
//  Copyright © 2015 nmg82. All rights reserved.
//

import Foundation

struct NSCodingStore: PersistentStoreProtocol {
  private let fileManager = NSFileManager.defaultManager()
  
  func persist(item: Item) {
    do {
      let documentDirectory = try fileManager.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
      let saveFile = documentDirectory.URLByAppendingPathComponent("data.bin")
      
      let data = NSKeyedArchiver.archivedDataWithRootObject(NSCodingItem(name: item.name, description: item.description))
      data.writeToURL(saveFile, atomically: true)
    } catch {
      
    }
  }
  
  func getItems() -> [Item] {
    return [Item]()
  }
}