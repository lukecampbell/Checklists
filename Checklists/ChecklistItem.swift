//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Lucas Campbell on 4/6/17.
//  Copyright © 2017 Lucas Campbell. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false

    init() {
        text = ""
        checked = false
    }

    init(_ text: String) {
        self.text = text
        checked = false
    }

    init(_ text: String, withChecked: Bool) {
        self.text = text
        checked = withChecked
    }

    func toggleChecked() {
        checked = !checked
    }
}
