//
//  ItemParser.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 12/25/15.
//  Copyright © 2015 nmg82. All rights reserved.
//

import Foundation

class ItemParser: NSObject {
  var xmlParser: NSXMLParser?
  var items = [Item]()
  var xmlText = ""
  var currentItem: Item?
  
  init(withXml xml: String) {
    if let xmlData = xml.dataUsingEncoding(NSUTF8StringEncoding) {
      xmlParser = NSXMLParser(data: xmlData)
    }
  }
  
  func parse() -> [Item] {
    xmlParser?.delegate = self
    xmlParser?.parse()
    return items
  }
}

extension ItemParser: NSXMLParserDelegate {
  func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
    
    xmlText = ""
    
    if elementName == "item" {
      currentItem = Item(name: "", description: "")
    }
    
  }
  
  func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    if elementName == "name" {
      currentItem?.name = xmlText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    if elementName == "description" {
      currentItem?.description = xmlText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    if elementName == "item" {
      if let item = currentItem {
        items.append(item)
      }
    }
  }
  
  func parser(parser: NSXMLParser, foundCharacters string: String) {
    xmlText += string
  }
}