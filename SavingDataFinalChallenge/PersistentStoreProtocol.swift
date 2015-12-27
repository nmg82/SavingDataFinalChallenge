//
//  PersistentStoreProtocol.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 12/19/15.
//  Copyright © 2015 nmg82. All rights reserved.
//

import Foundation

//rename to PersistentStore
protocol PersistentStoreProtocol {
  func persist(item: Item)
  func getItems() -> [Item]
}