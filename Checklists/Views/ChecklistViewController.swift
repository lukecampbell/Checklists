//
//  Checklists/ChecklistViewController.swift
//  Checklists
//
//  Created by Lucas Campbell on 4/6/17.
//  Copyright © 2017 Lucas Campbell
//  See LICENSE for details
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {

    //------------------------------------------------------------
    // MARK: Properties
    //------------------------------------------------------------
    enum tags: Int {
        case cellLabel = 1000
        case checkMark = 1001
    }

    var items: [CheckListItem]

    required init?(coder aDecoder: NSCoder) {
        items = [CheckListItem]()
        super.init(coder: aDecoder)

        loadChecklistItems()
    }

    //------------------------------------------------------------
    // MARK: UITableViewController overrides
    //------------------------------------------------------------

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
        let item = items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckMark(for: cell, with: item)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckMark(for: cell, with: item)
            saveChecklistItems()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            saveChecklistItems()
        }
    }

    //------------------------------------------------------------
    // MARK: Rendering Cells
    //------------------------------------------------------------

    /**
        Updates the cell's label with the text from the item.

        - Parameter cell: The cell to update
        - Parameter item: The item to update from
    */
    func configureText(for cell: UITableViewCell, with item: CheckListItem) {
        let label = cell.viewWithTag(tags.cellLabel.rawValue) as! UILabel
        label.text = item.text
    }

    /**
        Updates the cell's check mark based on the item's checked property.

        - Parameter cell: The cell to update
        - Parameter item: The item to update from
    */
    func configureCheckMark(for cell: UITableViewCell, with item: CheckListItem) {
        let checkMark = cell.viewWithTag(tags.checkMark.rawValue) as! UILabel;
        if (item.checked) {
            checkMark.text = "✓"
        } else {
            checkMark.text = ""
        }
    }

    //------------------------------------------------------------
    // MARK: Updating Items
    //------------------------------------------------------------

    /**
        Adds an item to items and inserts a cell with the contents for that item.
        
        - Parameter item: Item to add
     */
    func addItem(_ item: CheckListItem) {
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    /**
        Updates an existing item and updates the cell's contents for that item.

        - Parameter item: Item to update
    */
     
    func updateItem(_ item: CheckListItem) {
        if let index = items.index(of: item) {
            updateCell(at: IndexPath(row: index, section: 0))
        }
    }


    /**
        Updates the cell's contents with the values from the item matching the index of the cell.

        - Parameter index: The index of the cell to update
    */
    func updateCell(at index: IndexPath) {
        let item = items[index.row]
        if let cell = tableView.cellForRow(at: index) {
            configureText(for: cell, with: item)
            configureCheckMark(for: cell, with: item)
        }
    }

    //------------------------------------------------------------
    // MARK: Persistence
    //------------------------------------------------------------

    /**
        Returns the URL for the Documents directory
    */
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    /**
        Returns the URL for Documents/Checklists.plist
    */
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }

    /**
        Sets items to the decoded contents of Documents/Checklists.plist
    */
    func loadChecklistItems() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            items = unarchiver.decodeObject(forKey: "ChecklistItems") as! [CheckListItem]
            unarchiver.finishDecoding()
        }
    }

    /**
        Writes the encoded value of items to Documents/Checklists.plist
    */
    func saveChecklistItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(items, forKey: "ChecklistItems")
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }

    //------------------------------------------------------------
    // MARK: Segue Management
    //------------------------------------------------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAddItem" {
            prepareAddSegue(segue)
        } else if segue.identifier == "segueEditItem" {
            prepareEditSegue(segue, cell: sender as! UITableViewCell)
        }
    }

    /**
        Sets self as the delegate for the destination UINavigationController>

        - Parameter segue: The segue
    */
    func prepareAddSegue(_ segue: UIStoryboardSegue) {
        let navigationController = segue.destination as! UINavigationController
        let controller = navigationController.topViewController as! AddItemViewController
        controller.delegate = self
    }

    /**
        Sets self as the delegate for the destination UINavigationController
        and sets itemToEdit of the AddItemViewController to the item in the cell.

        - Parameter segue: The segue
        - Parameter cell: The instance of the cell being edited
    */
    func prepareEditSegue(_ segue: UIStoryboardSegue, cell: UITableViewCell) {
        let navigationController = segue.destination as! UINavigationController
        let controller = navigationController.topViewController as! AddItemViewController
        if let indexPath = tableView.indexPath(for: cell) {
            controller.itemToEdit = items[indexPath.row]
        }
        controller.delegate = self
    }

    //------------------------------------------------------------
    // MARK: AddItemViewControllerDelegate Protocol Implementation
    //------------------------------------------------------------

    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        controller.dismiss(animated: true)
    }

    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: CheckListItem) {
        controller.dismiss(animated: true)
        addItem(item)
        saveChecklistItems()
    }

    func addItemViewController(_ controller: AddItemViewController, didFinishEditing item: CheckListItem) {
        controller.dismiss(animated: true)
        updateItem(item)
        saveChecklistItems()
    }
    
}
