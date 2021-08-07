//
//  Post.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/5/21.
//

import UIKit

class Post: NSObject {
    var userName: String
    var date: String
    var companyName: String
    var content: String
    var hasSent: Bool
    var tags: [String]
    var address: String
    
    init(userName: String, date: String, companyName: String, content: String, hasSent: Bool, tags: [String], address: String) {
        self.userName = userName
        self.date = date
        self.companyName = companyName
        self.content = content
        self.hasSent = hasSent
        self.tags = tags
        self.address = address
    }
    
    func updateDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        self.date = formatter.string(from: date)
    }
}
