//
//  NSCodingItem.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 12/20/15.
//  Copyright © 2015 nmg82. All rights reserved.
//

import Foundation

class NSCodingItem: NSObject, NSCoding {
  var item: Item
  
  init(name: String, description: String) {
    item = Item(name: name, description: description)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    guard let name = aDecoder.decodeObjectForKey("name") as? String,
        description = aDecoder.decodeObjectForKey("description") as? String
      else {
        return nil
    }
    
    self.init(name: name, description: description)
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(item.name, forKey: "name")
    aCoder.encodeObject(item.description, forKey: "description")
  }
}