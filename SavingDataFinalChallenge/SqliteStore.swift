//
//  SqliteStore.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 12/28/15.
//  Copyright © 2015 nmg82. All rights reserved.
//

import Foundation

struct SqliteStore: PersistentStore {
  init () {
   //create tables here?
  }
  
  func persist(item: Item) {
    
  }
  
  func getItems() -> [Item] {
    return []
  }
}