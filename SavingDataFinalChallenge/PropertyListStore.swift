//
//  PropertyListStore.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 12/22/15.
//  Copyright © 2015 nmg82. All rights reserved.
//

import Foundation

struct PropertyListStore: PersistentStore {
  private let saveFile: NSURL? = {
    do {
      let documentDirectory = try NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
      return documentDirectory.URLByAppendingPathComponent("items.plist")
    } catch {
      print(error)
      return nil
    }
  }()
  
  func persist(item: Item) {
    guard let saveFile = saveFile else {
      return
    }
    
    var items = getDeserializedItems()
    items.append(["name": item.name, "description": item.description])
    
    do {
      let itemData = try NSPropertyListSerialization.dataWithPropertyList(items, format: NSPropertyListFormat.XMLFormat_v1_0, options: 0)
      itemData.writeToURL(saveFile, atomically: true)
    } catch {
      print(error)
    }
  }
  
  private func getDeserializedItems() -> [[String: AnyObject]] {
    guard let saveFile = saveFile,
      let plistData = NSData(contentsOfURL: saveFile) else {
      return [[:]]
    }
    
    do {
      var format = NSPropertyListFormat.XMLFormat_v1_0
      if let deserializedItems = try NSPropertyListSerialization.propertyListWithData(plistData, options: .Immutable, format: &format) as? [[String: AnyObject]] {
        return deserializedItems
      }
    } catch {
      print(error)
    }
    
    return [[:]]
  }
  
  func getItems() -> [Item] {
    var items = [Item]()
    
    for item in getDeserializedItems() {
      if let name = item["name"] as? String,
        description = item["description"] as? String {
          items.append(Item(name: name, description: description))
      }
    }
    
    return items
  }
}