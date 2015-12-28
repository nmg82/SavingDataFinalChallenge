//
//  JsonStore.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 12/28/15.
//  Copyright © 2015 nmg82. All rights reserved.
//

import Foundation

struct JsonStore: PersistentStore {
  private let saveFile: NSURL? = {
    do {
      let documentDirectory = try NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
      
      return documentDirectory.URLByAppendingPathComponent("data.json")
    } catch {
      print(error)
      return nil
    }
  }()
  
  func persist(item: Item) {
    guard let saveFile = saveFile else {
      return
    }
    
    var items = getItems()
    items.append(item)
    
    var topLevel:[AnyObject] = []
    
    for item in items {
      var itemDict = [String: AnyObject]()
      itemDict["name"] = item.name
      itemDict["description"] = item.description
      
      topLevel.append(itemDict)
    }
    
    do {
      let jsonData = try NSJSONSerialization.dataWithJSONObject(topLevel, options: .PrettyPrinted)
      jsonData.writeToURL(saveFile, atomically: true)
    } catch {
      print(error)
    }
  }
  
  func getItems() -> [Item] {
    var items = [Item]()
    
    do {
      guard let saveFile = saveFile where NSFileManager.defaultManager().fileExistsAtPath(saveFile.path!),
            let jsonData = NSData(contentsOfURL: saveFile),
            let parsedItems = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as? [[String: AnyObject]]
        else {
        return items
      }
      
      for item in parsedItems {
        guard let name = item["name"] as? String,
              let description = item["description"] as? String
          else {
          continue
        }
        
        items.append(Item(name: name, description: description))
      }
      
    } catch {
      print(error)
    }
    
    return items
  }
}