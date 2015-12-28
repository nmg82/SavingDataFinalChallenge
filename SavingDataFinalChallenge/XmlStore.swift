//
//  XmlStore.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 12/25/15.
//  Copyright © 2015 nmg82. All rights reserved.
//

import Foundation

struct XmlStore: PersistentStoreProtocol {
  private let saveFile: NSURL? = {
    do {
      let documentDirectory = try NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
      
      return documentDirectory.URLByAppendingPathComponent("data.xml")
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
    
    let xmlString = ItemXmlGenerator.getXmlFromItems(items)
    xmlString.dataUsingEncoding(NSUTF8StringEncoding)?.writeToURL(saveFile, atomically: true)
  }
  
  func getItems() -> [Item] {
    var items = [Item]()
    
    do {
      guard let saveFile = saveFile where NSFileManager.defaultManager().fileExistsAtPath(saveFile.path!) else {
        return items
      }
      
      let xml = try String(contentsOfURL: saveFile)
      let parser = ItemParser(withXml: xml)
      
      items = parser.parse()
      
    } catch {
      print(error)
    }
    
    return items
  }
}