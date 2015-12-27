//
//  XmlStore.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 12/25/15.
//  Copyright © 2015 nmg82. All rights reserved.
//

import Foundation

struct XmlStore: PersistentStoreProtocol {
  func persist(item: Item) {
    let documentDirectory = NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
    
    let saveFile = documentDirectory.URLByAppendingPathComponent("data.xml")
    
    //parse item
    
    
  }
  
  func getItems() -> [Item] {
    return []
  }
}