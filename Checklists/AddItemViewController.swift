//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Lucas Campbell on 4/6/17.
//  Copyright © 2017 Lucas Campbell. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(_ controler: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: CheckListItem)
    func addItemViewController(_ controller: AddItemViewController, didFinishEditing item: CheckListItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {

    //------------------------------------------------------------
    // MARK: Outlets
    //------------------------------------------------------------
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!

    //------------------------------------------------------------
    // MARK: Properties
    //------------------------------------------------------------
    
    /// The delegate to handle done or cancel being clicked
    weak var delegate: AddItemViewControllerDelegate?
    /// If set the view will update this item with the text
    var itemToEdit: CheckListItem?

    //------------------------------------------------------------
    // MARK: UITableViewController Overrides
    //------------------------------------------------------------

    override func viewDidLoad() {
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneButton.isEnabled = true
        }
    }
    
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
    
    //------------------------------------------------------------
    // MARK: Actions
    //------------------------------------------------------------

    /**
        Calls updateCheckListView with the value entered in the text field
     */
    @IBAction func done(_ sender: Any) {
        if let item = itemToEdit {
            item.text = textField.text ?? ""
            delegate?.addItemViewController(self, didFinishEditing: item)
        } else {
            let item = CheckListItem(textField.text ?? "")
            delegate?.addItemViewController(self, didFinishAdding: item)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
}
