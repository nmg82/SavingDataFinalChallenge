//
//  NSDataStore.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 12/19/15.
//  Copyright © 2015 nmg82. All rights reserved.
//

import Foundation

struct StringStore: PersistentStore {
  let fileManager = NSFileManager.defaultManager()
  
  func persist(item: Item) {
    do {
      let documentDirectory = try fileManager.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
      let savedItemFiles = try fileManager.contentsOfDirectoryAtURL(documentDirectory, includingPropertiesForKeys: nil, options: .SkipsHiddenFiles)
      
      print(documentDirectory)
      
      let nameFiles = savedItemFiles.filter{ $0.absoluteString.rangeOfString("name") != nil }
      let descriptionFiles = savedItemFiles.filter{ $0.absoluteString.rangeOfString("description") != nil }
      
      let nameFile = NSURL(string: "name-\(nameFiles.count).txt", relativeToURL: documentDirectory)!
      try item.name.writeToURL(nameFile, atomically: true, encoding: NSUTF8StringEncoding)
      
      let descriptionFile = NSURL(string: "description-\(descriptionFiles.count).txt", relativeToURL: documentDirectory)!
      try item.description.writeToURL(descriptionFile, atomically: true, encoding: NSUTF8StringEncoding)
      
    } catch {
      print("Error writing strings to URL \(error)")
    }
  }
  
  func getItems() -> [Item] {
    var items = [Item]()
    
    do {
      let documentDirectory = try fileManager.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
      let files = try fileManager.contentsOfDirectoryAtURL(documentDirectory, includingPropertiesForKeys: nil, options: .SkipsHiddenFiles)
      
      let nameFiles = files.filter{ $0.absoluteString.rangeOfString("name") != nil }
      let descriptionFiles = files.filter{ $0.absoluteString.rangeOfString("description") != nil }
      
      for i in 0..<nameFiles.count where nameFiles.count == descriptionFiles.count {
        items.append(
          Item(
            name: try String(contentsOfURL: nameFiles[i]),
            description: try String(contentsOfURL: descriptionFiles[i])
          )
        )
      }
      
    } catch {
      print(error)
    }
    
    return items
  }
}