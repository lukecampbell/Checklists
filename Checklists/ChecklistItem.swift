//
//  CheckListItem.swift
//  Checklists
//
//  Created by Lucas Campbell on 4/6/17.
//  Copyright © 2017 Lucas Campbell. All rights reserved.
//

import Foundation

class CheckListItem: NSObject {
    var text = ""
    var checked = false

    override init() {
        text = ""
        checked = false
        super.init()
    }

    init(_ text: String) {
        self.text = text
        checked = false
        super.init()
    }

    init(_ text: String, withChecked: Bool) {
        self.text = text
        checked = withChecked
        super.init()
    }

    func toggleChecked() {
        checked = !checked
    }
}
