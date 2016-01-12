//
//  SqliteStore.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 12/28/15.
//  Copyright © 2015 nmg82. All rights reserved.
//

import Foundation

struct SqliteStore: PersistentStore {
  let flags = SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE
  let insertStatement = "CREATE TABLE if not exists Items (ItemID integer primary key autoincrement, Name text, Description text);"
  
  let dbUrl: NSURL? = {
    do {
      let baseUrl = try NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
      return baseUrl.URLByAppendingPathComponent("items.sqlite")
    } catch {
      print(error)
      return nil
    }
  }()
  
  init () {
    guard let dbUrl = dbUrl else {
      return
    }
    var sqliteDB: COpaquePointer = nil
    sqlite3_open_v2(dbUrl.absoluteString.cStringUsingEncoding(NSUTF8StringEncoding)!, &sqliteDB, flags, nil)
    sqlite3_exec(sqliteDB, insertStatement, nil, nil, nil)
    sqlite3_close(sqliteDB)
  }
  
  func persist(item: Item) {
    let insertItemSql = "insert into Items (Name, Description) values ('\(item.name)', '\(item.description)');"
    
    guard let dbUrl = dbUrl else {
      return
    }
    
    var sqliteDB: COpaquePointer = nil
    sqlite3_open_v2(dbUrl.absoluteString.cStringUsingEncoding(NSUTF8StringEncoding)!, &sqliteDB, flags, nil)
    
    var statement: COpaquePointer = nil
    sqlite3_prepare(sqliteDB, insertItemSql, -1, &statement, nil)
    sqlite3_step(statement)
    sqlite3_finalize(statement)
    sqlite3_close(sqliteDB)
  }
  
  func getItems() -> [Item] {
    var items = [Item]()
    
    guard let dbUrl = dbUrl else {
      return items
    }
    
    var sqliteDB: COpaquePointer = nil
    sqlite3_open_v2(dbUrl.absoluteString.cStringUsingEncoding(NSUTF8StringEncoding)!, &sqliteDB, flags, nil)
    
    let selectSql = "select * from Items;"
    var itemSelect: COpaquePointer = nil
    
    if sqlite3_prepare_v2(sqliteDB, selectSql, -1, &itemSelect, nil) == SQLITE_OK {
      while sqlite3_step(itemSelect) == SQLITE_ROW {
        let name = UnsafePointer<CChar>(sqlite3_column_text(itemSelect, 1))
        let description = UnsafePointer<CChar>(sqlite3_column_text(itemSelect, 2))
        
        let nameString = String.fromCString(name)!
        let descriptionString = String.fromCString(description)!
        
        let item = Item(name: nameString, description: descriptionString)
        
        items.append(item)
      }
    }
    
    sqlite3_finalize(itemSelect)
    sqlite3_close(sqliteDB)
    
    return items
  }
}