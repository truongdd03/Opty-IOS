//
//  Job.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/31/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class Job: NSObject, Codable {
    @DocumentID var id: String?
    var company = ""
    var role = ""
    var content = ""
    var tags: [String] = []
    var duration = ""
    
    init(company: String, role: String, tags: [String], content: String?, duration: String) {
        self.company = company
        self.role = role
        self.tags = tags
        self.content = content ?? ""
        self.duration = duration + "yr(s)"
    }
    
    func parseToString() -> String {
        var content = "\(self.role) at \(self.company) for \(self.duration) years. \(self.content)."
        return content
    }
}
