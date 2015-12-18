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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func saveButtonPressed() {
      print("saving data")
      print(nameTextField.text)
      print(descriptionTextView.text)
      
      self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
