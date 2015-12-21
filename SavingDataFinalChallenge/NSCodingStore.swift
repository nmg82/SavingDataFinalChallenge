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
      
      var items = getNSCodingItems()
      items.append(NSCodingItem(name: item.name, description: item.description))
      
      let data = NSKeyedArchiver.archivedDataWithRootObject(items)
      data.writeToURL(saveFile, atomically: true)
      
    } catch {
      print(error)
    }
  }
  
  private func getNSCodingItems() -> [NSCodingItem] {
    do {
      let documentDirectory = try fileManager.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
      let saveFile = documentDirectory.URLByAppendingPathComponent("data.bin")
      
      if (!fileManager.fileExistsAtPath(saveFile.path!)) {
        return []
      }
      
      let data = try NSData(contentsOfURL: saveFile, options: .DataReadingMappedIfSafe)
      let unarchivedData = NSKeyedUnarchiver.unarchiveObjectWithData(data)
      
      if let nsCodingItems = unarchivedData as? [NSCodingItem] {
        return nsCodingItems
      }
      
    } catch {
      print(error)
    }
    
    return []
  }
  
  func getItems() -> [Item] {
    var items = [Item]()
    
    for nsCodingItem in getNSCodingItems() {
      items.append(nsCodingItem.item)
    }

    return items
  }
}