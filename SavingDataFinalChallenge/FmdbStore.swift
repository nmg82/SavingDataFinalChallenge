//
//  FmdbStore.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 1/12/16.
//  Copyright © 2016 nmg82. All rights reserved.
//

import Foundation

struct FmdbStore: PersistentStore {
  
  let createStatement = "CREATE TABLE if not exists Items (ItemID integer primary key autoincrement, Name text, Description text);"
  
  let dbUrl: NSURL? = {
    do {
      let baseUrl = try NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
      return baseUrl.URLByAppendingPathComponent("items_fmdb.sqlite")
    } catch {
      print(error)
      return nil
    }
  }()
  
  init () {
    guard let dbUrl = dbUrl,
      fmdb = FMDatabase(path: dbUrl.absoluteString) else {
        return
    }
    
    defer {
      fmdb.close()
    }

    fmdb.open()
    
    do {
      try fmdb.executeUpdate(createStatement, values: nil)
    } catch {
      print(error)
    }
  }
  
  func persist(item: Item) {
    let insertItemSql = "insert into Items (Name, Description) values ('\(item.name)', '\(item.description)');"
    
    guard let dbUrl = dbUrl,
      fmdb = FMDatabase(path: dbUrl.absoluteString) else {
        return
    }
    
    defer {
      fmdb.close()
    }
    
    fmdb.open()
    
    do {
      try fmdb.executeUpdate(insertItemSql, values: nil)
    } catch {
      print(error)
    }
  }
  
  func getItems() -> [Item] {
    var items = [Item]()
    
    guard let dbUrl = dbUrl,
      fmdb = FMDatabase(path: dbUrl.absoluteString) else {
      return items
    }
    
    defer {
      fmdb.close()
    }
    
    fmdb.open()
    
    let selectSql = "select * from Items;"
    let result = fmdb.executeQuery(selectSql, withParameterDictionary: nil)
    
    while result.next() {
      let name = result.stringForColumn("Name")
      let description = result.stringForColumn("Description")
      let item = Item(name: name, description: description)
      
      items.append(item)
    }
    
    return items
  }
}