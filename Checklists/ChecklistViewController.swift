//
//  Checklists/ChecklistViewController.swift
//  Checklists
//
//  Created by Lucas Campbell on 4/6/17.
//  Copyright © 2017 Lucas Campbell. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    enum tags: Int {
        case cellLabel = 1000
        case checkMark = 1001
    }

    var items: [ChecklistItem]

    required init?(coder aDecoder: NSCoder) {
        items = [ChecklistItem]()
        items.append(ChecklistItem("Walk the Dog"))
        items.append(ChecklistItem("Brush my teeth", withChecked: true))
        items.append(ChecklistItem("Learn iOS Development", withChecked: true))
        items.append(ChecklistItem("Soccer practice"))
        items.append(ChecklistItem("Eat ice cream", withChecked: true))

        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
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
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    

    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(tags.cellLabel.rawValue) as! UILabel
        label.text = item.text
    }

    func configureCheckMark(for cell: UITableViewCell, with item: ChecklistItem) {
        let checkMark = cell.viewWithTag(tags.checkMark.rawValue) as! UILabel;
        if (item.checked) {
            checkMark.text = "✓"
        } else {
            checkMark.text = ""
        }
    }

    /*****************************************
     * Actions
     *****************************************/
    
    @IBAction func addItem(_ sender: Any) {
        let item = ChecklistItem("I am a new role")
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

}
