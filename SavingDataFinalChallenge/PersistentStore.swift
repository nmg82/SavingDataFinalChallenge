//
//  PersistentStoreProtocol.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 12/19/15.
//  Copyright © 2015 nmg82. All rights reserved.
//

import Foundation

protocol PersistentStore {
  func persist(item: Item)
  func getItems() -> [Item]
}