//
//  ItemXmlGenerator.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 12/28/15.
//  Copyright © 2015 nmg82. All rights reserved.
//

import Foundation

struct ItemXmlGenerator {
  static func getXmlFromItems(items: [Item]) -> String {
    var xmlString = "<items>"
    
    for item in items {
      xmlString += "<item>"
      xmlString += "<name>\(item.name)</name>"
      xmlString += "<description>\(item.description)</description>"
      xmlString += "</item>"
    }
    
    xmlString += "</items>"
    
    return xmlString
  }
}