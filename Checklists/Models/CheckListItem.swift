//
//  CheckListItem.swift
//  Checklists
//
//  Created by Lucas Campbell on 4/6/17.
//  Copyright © 2017 Lucas Campbell. All rights reserved.
//

import Foundation

class CheckListItem: NSObject, NSCoding {
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

    //------------------------------------------------------------
    // MARK: NSCoding Protocol
    //------------------------------------------------------------

    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "text") as! String
        checked = aDecoder.decodeBool(forKey: "checked")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "text")
        aCoder.encode(checked, forKey: "text")
    }
}
