//
//  Job.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/31/21.
//

import UIKit

class Job: NSObject {
    var company = ""
    var role = ""
    var tags: [String] = []
    
    init(company: String, role: String, tags: [String]) {
        self.company = company
        self.role = role
        self.tags = tags
    }
}
