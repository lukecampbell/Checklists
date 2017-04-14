//
//  Errors.swift
//  Checklists
//
//  Created by Lucas Campbell on 4/14/17.
//  Copyright © 2017 Lucas Campbell. All rights reserved.
//

import Foundation

class TagError: NSError {
    enum codes: Int {
        case NotFound = 1
    }
    override init(domain: String, code: Int, userInfo dict: [AnyHashable : Any]? = nil) {
        super.init(domain:"Tags", code: code, userInfo: dict)
    }
    
    init(code: Int) {
        super.init(domain: "Tags", code: code)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
