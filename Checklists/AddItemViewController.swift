//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Lucas Campbell on 4/6/17.
//  Copyright © 2017 Lucas Campbell. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        doneButton.isEnabled = (newText.length > 0)
        return true
    }
    
    func updateChecklistView(_ text: String) {
        
    }

    /*************************************************************
     * Actions
     *************************************************************/

    /**
     * Calls updateCheckListView with the value entered in the text field
     */
    @IBAction func done(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
}
