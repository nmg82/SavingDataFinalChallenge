//
//  ItemViewController.swift
//  SavingDataFinalChallenge
//
//  Created by Nathan Gladson on 12/18/15.
//  Copyright © 2015 nmg82. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var descriptionTextView: UITextView!
  
  private let persistentStore = PersistentStoreFactory.getPersistentStore()
  
  var itemToEdit: Item?
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    if let itemToEdit = itemToEdit {
      nameTextField.text = itemToEdit.name
      descriptionTextView.text = itemToEdit.description
    }
  }
  
  @IBAction func saveButtonPressed() {
    let item = Item(name: nameTextField.text!, description: descriptionTextView.text)

    persistentStore.persist(item)
    
    self.navigationController?.popToRootViewControllerAnimated(true)
  }
}
