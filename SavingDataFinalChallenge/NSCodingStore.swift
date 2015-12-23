//
//  NSCodingDataStore.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 12/19/15.
//  Copyright © 2015 nmg82. All rights reserved.
//

import Foundation

struct NSCodingStore: PersistentStoreProtocol {
  private let saveFile: NSURL? = {
    do {
      let documentDirectory = try NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
      return documentDirectory.URLByAppendingPathComponent("data.bin")
    } catch {
      print(error)
      return nil
    }
  }()
  
  func persist(item: Item) {
    guard let saveFile = saveFile else {
      return
    }
    
    var items = getNSCodingItems()
    items.append(NSCodingItem(name: item.name, description: item.description))
    
    let data = NSKeyedArchiver.archivedDataWithRootObject(items)
    data.writeToURL(saveFile, atomically: true)
  }
  
  private func getNSCodingItems() -> [NSCodingItem] {
    guard let saveFile = saveFile
      where NSFileManager.defaultManager().fileExistsAtPath(saveFile.path!)
        else {
      return []
    }
    
    do {
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