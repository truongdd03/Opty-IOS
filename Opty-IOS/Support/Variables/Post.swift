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
    var tags: [String]
    
    init(userName: String, date: String, companyName: String, content: String, tags: [String]) {
        self.userName = userName
        self.date = date
        self.companyName = companyName
        self.content = content
        self.tags = tags
    }
}
