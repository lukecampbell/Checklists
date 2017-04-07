//
//  Checklists/ChecklistViewController.swift
//  Checklists
//
//  Created by Lucas Campbell on 4/6/17.
//  Copyright © 2017 Lucas Campbell. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }

    func configureCheckMark(for cell: UITableViewCell, with item: ChecklistItem) {
        cell.accessoryType = item.checked ? .checkmark : .none
    }

}
